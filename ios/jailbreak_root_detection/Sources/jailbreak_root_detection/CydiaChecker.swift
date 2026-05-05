//
//  CydiaChecker.swift
//  jailbreak_root_detection
//
//  Created by M on 23/1/2566 BE.
//

import Foundation

class CydiaChecker {
    
    static func isFound() -> Bool {
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") {
            return true
        }
        if FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") {
            return true
        }
        if FileManager.default.fileExists(atPath: "/bin/bash") {
            return true
        }
        let system = NSString(string: "system").utf8String
        var s = stat()
        if stat(system, &s) == 0 {
            return true
        }
        return false
    }
}
