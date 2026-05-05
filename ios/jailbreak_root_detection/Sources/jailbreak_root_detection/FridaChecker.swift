//
//  FridaChecker.swift
//  jailbreak_root_detection
//
//  Created by M on 23/1/2566 BE.
//

import Foundation


class FridaChecker {
    
    static func isFound() -> Bool {
        let fridaServerFile = FileManager.default.fileExists(atPath: "/usr/bin/frida-server")
        let fridaLibraryFile = FileManager.default.fileExists(atPath: "/usr/lib/libfrida-core.dylib")
        if fridaServerFile || fridaLibraryFile {
            return true
        }
        return false
    }
}
