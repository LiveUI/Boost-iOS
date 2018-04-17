//
//  Networking.swift
//  BoostSDK
//
//  Created by Ondrej Rafaj on 01/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation


public class Networking {
    
    public typealias DataResponseTuple = (data: Data, response: URLResponse)
    
    let baseUrl: URL
    
    var jwtToken: String?
    
    public enum Problem: Error {
        case unknownError
        case invalidPath
        case badToken
    }
    
    var reauthenticate: (() throws -> Promise<Token>)?
    
    // MARK: Initialization
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    // MARK: Request methods
    
    func get(path: String, _ result: @escaping ((_ result: Result<DataResponseTuple>) -> ())) throws {
        return makeRequest(path: path, method: "GET", result)
    }
    
    func post(path: String, data: Data, _ result: @escaping ((_ result: Result<DataResponseTuple>) -> ())) throws {
        return makeRequest(path: path, data: data, method: "POST", result)
    }
    
    func post(path: String, object: Encodable, _ result: @escaping ((_ result: Result<DataResponseTuple>) -> ())) throws {
        let data = try object.asData()
        return makeRequest(path: path, data: data, method: "POST", headers: ["Content-Type": "application/json; charset=utf8"], result)
    }
    
    func put(path: String, data: Data, _ result: @escaping ((_ result: Result<DataResponseTuple>) -> ())) throws {
        return makeRequest(path: path, data: data, method: "PUT", result)
    }
    
    func put(path: String, object: Encodable, _ result: @escaping ((_ result: Result<DataResponseTuple>) -> ())) throws {
        let data = try object.asData()
        return makeRequest(path: path, data: data, method: "PUT", headers: ["Content-Type": "application/json; charset=utf8"], result)
    }
    
    func delete(path: String, _ result: @escaping ((_ result: Result<DataResponseTuple>) -> ())) throws {
        return makeRequest(path: path, method: "DELETE", result)
    }
    
    func makeRequest(path: String, data: Data? = nil, method: String, headers: [String: String] = [:], _ result: @escaping ((_ result: Result<DataResponseTuple>) -> ())) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let parts = path.split(separator: "?").map { String($0) }
        
        var request: URLRequest
        let url = baseUrl.appendingPathComponent(parts[0])
        if parts.count == 2, let query = parts.last, var components = URLComponents(string: url.absoluteString) {
            components.query = query
            request = URLRequest(url: components.url ?? url)
        } else {
            request = URLRequest(url: url)
        }
        
        
        if let data = data {
            request.httpBody = data
        }
        request.httpMethod = method
        var headers = headers
        if let jwtToken = jwtToken {
            headers["Authorization"] = jwtToken
        }
        request.allHTTPHeaderFields = headers
        
        let task = session.dataTask(with: request) { (responseData, response, error) in
            if let error = error {
                result(Result.error(error))
                return
            }
            if let responseData = responseData, let response = response as? HTTPURLResponse {
                Debug.request(request, response: response, data: responseData)
                if response.statusCode == 401 {
                    if path != "token", path != "auth" {
                        Debug.print("Unauthorised, trying to refresh token")
                        do {
                            try self.reauthenticate?().then({ token in
                                DispatchQueue.main.async {
                                    self.makeRequest(path: path, data: data, method: method, headers: headers, result)
                                }
                            }).error({ error in
                                result(Result.error(Problem.badToken))
                            })
                            return
                        } catch {
                            result(Result.error(error))
                            return
                        }
                    } else {
                        Debug.print("Unauthorised, unable to refresh token on auth endpoints")
                        result(Result.error(Problem.unknownError))
                    }
                }
                if let auth = (response.allHeaderFields["authorization"] ?? response.allHeaderFields["Authorization"]) as? String {
                    self.jwtToken = auth
                }
                result(Result.success((data: responseData, response: response)))
            } else {
                result(Result.error(Problem.unknownError))
            }
        }
        
        task.resume()
        
        session.finishTasksAndInvalidate()
    }
    
}
