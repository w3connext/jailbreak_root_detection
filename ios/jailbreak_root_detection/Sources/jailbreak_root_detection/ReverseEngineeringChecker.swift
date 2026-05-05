//
//  ReverseEngineeringChecker.swift
//  jailbreak_root_detection
//
//  Created by M on 9/11/2566 BE.
//

import Foundation
import MachO // dyld
import IOSSecuritySuite

class ReverseEngineeringChecker {
    typealias CheckResult = (passed: Bool, failMessage: String)

    struct ReverseEngineeringStatus {
        let passed: Bool
    }

    static func amIReverseEngineered() -> Bool {
        return !performChecks().passed
    }
  
    private static func performChecks() -> ReverseEngineeringStatus {
        var passed = true
        var result: CheckResult = (true, "")
        
        for check in FailedCheck.allCases {
            switch check {
            case .existenceOfSuspiciousFiles:
                result = checkExistenceOfSuspiciousFiles()
            case .dyld:
                result = checkDYLD()
            case .openedPorts:
                result = checkOpenedPorts()
            default:
              continue
            }

            passed = passed && result.passed
        }

        return ReverseEngineeringStatus(passed: passed)
    }

    private static func checkDYLD() -> CheckResult {

        let suspiciousLibraries: Set<String> = [
            "FridaGadget",
            "frida", // Needle injects frida-somerandom.dylib
            "cynject",
            "libcycript"
        ]

        for index in 0..<_dyld_image_count() {

            let imageName = String(cString: _dyld_get_image_name(index))

            // The fastest case insensitive contains check.
            for library in suspiciousLibraries where imageName.localizedCaseInsensitiveContains(library) {
                return (false, "Suspicious library loaded: \(imageName)")
            }
        }

        return (true, "")
    }

    private static func checkExistenceOfSuspiciousFiles() -> CheckResult {

        let paths = [
            "/usr/sbin/frida-server",
            "/private/etc/dpkg/origins/debian",
            "/private/var/lib/cydia/metadata.plist",
            "/private/var/mobile/Library/Preferences/com.saurik.CyDelete.plist",
            "/private/var/stash"
        ]

        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return (false, "Suspicious file found: \(path)")
            }
        }

        return (true, "")
    }

    private static func checkOpenedPorts() -> CheckResult {

        let ports = [
            27042, // default Frida
            4444, // default Needle
            22, // OpenSSH
            44 // checkra1n
        ]

        for port in ports {

            if canOpenLocalConnection(port: port) {
                return (false, "Port \(port) is open")
            }
        }

        return (true, "")
    }

    private static func canOpenLocalConnection(port: Int) -> Bool {

        func swapBytesIfNeeded(port: in_port_t) -> in_port_t {
            let littleEndian = Int(OSHostByteOrder()) == OSLittleEndian
            return littleEndian ? _OSSwapInt16(port) : port
        }

        var serverAddress = sockaddr_in()
        serverAddress.sin_family = sa_family_t(AF_INET)
        serverAddress.sin_addr.s_addr = inet_addr("127.0.0.1")
        serverAddress.sin_port = swapBytesIfNeeded(port: in_port_t(port))
        let sock = socket(AF_INET, SOCK_STREAM, 0)

        let result = withUnsafePointer(to: &serverAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                connect(sock, $0, socklen_t(MemoryLayout<sockaddr_in>.stride))
            }
        }
        
        defer {
            close(sock)
        }

        if result != -1 {
            return true // Port is opened
        }

        return false
    }
}
