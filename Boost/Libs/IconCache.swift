//
//  IconCache.swift
//  Boost
//
//  Created by Ondrej Rafaj on 07/11/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import BoostSDK


class IconCache {
    
    static func cache(data: Data, appId: UUID) throws {
        let path = iconPath(appId: appId)
        let dir = path.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        try data.write(to: path)
    }
    
    static func hasIcon(appId: UUID) -> Bool {
        let path = iconPath(appId: appId)
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    static func icon(appId: UUID) -> UIImage? {
        let path = iconPath(appId: appId)
        return UIImage(contentsOfFile: path.path)
    }
    
    static func cache(data: Data, teamId: UUID) throws {
        let path = iconPath(appId: teamId)
        let dir = path.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        try data.write(to: path)
    }
    
    static func hasIcon(teamId: UUID) -> Bool {
        let path = iconPath(appId: teamId)
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    static func icon(teamId: UUID) -> UIImage? {
        let path = iconPath(appId: teamId)
        return UIImage(contentsOfFile: path.path)
    }
    
    // MARK: Private helpers
    
    private static func iconPath(appId: UUID) -> URL {
        var url = homePath()
        url.appendPathComponent("apps")
        url.appendPathComponent(appId.uuidString)
        url.appendPathExtension("icon")
        return url
    }
    
    private static func iconPath(teamId: UUID) -> URL {
        var url = homePath()
        url.appendPathComponent("teams")
        url.appendPathComponent(teamId.uuidString)
        url.appendPathExtension("icon")
        return url
    }
    
    private static func homePath() -> URL {
        var home = URL(fileURLWithPath: NSHomeDirectory())
        home.appendPathComponent("cache")
        return home
    }
    
}
