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
    
    static func cache(data: Data, for appId: UUID) throws {
        let path = iconPath(for: appId)
        let dir = path.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        try data.write(to: path)
    }
    
    static func hasIcon(appId: UUID) -> Bool {
        let path = iconPath(for: appId)
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    static func icon(appId: UUID) -> UIImage? {
        let path = iconPath(for: appId)
        return UIImage(contentsOfFile: path.path)
    }
    
    
    
    private static func homePath() -> URL {
        var home = URL(fileURLWithPath: NSHomeDirectory())
        home.appendPathComponent("cache")
        home.appendPathComponent("apps")
        return home
    }
    
    private static func iconPath(for appId: UUID) -> URL {
        var url = homePath()
        url.appendPathComponent(appId.uuidString)
        url.appendPathExtension("icon")
        return url
    }
    
}
