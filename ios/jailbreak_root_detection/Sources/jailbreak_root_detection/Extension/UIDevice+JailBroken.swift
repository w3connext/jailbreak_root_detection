//
//  UIDevice+JailBroken.swift
//  IsJailBroken
//
//  Created by Vineet Choudhary on 07/02/20.
//  Copyright © 2020 Developer Insider. All rights reserved.
//
import Foundation
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
    
    var isJailBroken: Bool {
        get {
            if UIDevice.current.isSimulator { return false }
            if JailBrokenHelper.hasCydiaInstalled() { return true }
            if JailBrokenHelper.isContainsSuspiciousApps() { return true }
            if JailBrokenHelper.isSuspiciousSystemPathsExists() { return true }
            return JailBrokenHelper.canEditSystemFiles()
        }
    }
}

private struct JailBrokenHelper {
    static func hasCydiaInstalled() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: "cydia://")!)
    }
    
    static func isContainsSuspiciousApps() -> Bool {
        for path in suspiciousAppsPathToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    static func isSuspiciousSystemPathsExists() -> Bool {
        for path in suspiciousSystemPathsToCheck {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        return false
    }
    
    static func canEditSystemFiles() -> Bool {
        let jailBreakText = "Developer Insider"
        do {
            try jailBreakText.write(toFile: jailBreakText, atomically: true, encoding: .utf8)
            return true
        } catch {
            return false
        }
    }
    
    /**
     Add more paths here to check for jail break
     */
    static var suspiciousAppsPathToCheck: [String] {
        return ["/Applications/Cydia.app",
                "/Applications/blackra1n.app",
                "/Applications/FakeCarrier.app",
                "/Applications/Icy.app",
                "/Applications/IntelliScreen.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/WinterBoard.app",
                "/Applications/Snoop-itConfig.app",
                "/Applications/Cydia.app",
                "/Applications/Icy.app",
                "/Applications/MxTube.app",
                "/Applications/RockApp.app",
                "/Applications/SBSettings.app",
                "/Applications/WinterBoard.app",
                "/Applications/Snoop-itConfig.app",
                "/Applications/SBSetttings.app",
                "/Applications/IntelliScreenX.app",
                "/Applications/terminal.app",
                "/Applications/MewSeek.app",
                "/Applications/OmniStat.app",
                "/Applications/Poof.app",
                "/Applications/Terminal.app",
                "/Applications/iFile.app",
                "/Applications/Activator.app",
                "/Applications/checkra1n.app",
                "/var/checkra1n.dmg",
        ]
    }
    
    static var suspiciousSystemPathsToCheck: [String] {
        return ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                "/Library/MobileSubstrate/DynamicLibraries/Activator.dylib ",
                "/private/var/lib/apt",
                "/private/var/lib/apt/",
                "/private/var/lib/cydia",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/private/var/stash",
                "/private/var/tmp/cydia.log",
                "/System/Library/Caches/apticket.der",
                "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                "/System/Library/Caches/com.apple.dyld/dyld_shared_cache_armv7s",
                "/usr/bin/sshd",
                "/Library/Frameworks/CydiaSubstrate.framework",
                "/Library/PreferenceLoader/Preferences",
                "/Library/PreferenceBundles",
                "/usr/bin/ssh",
                "/usr/libexec/sftp-server",
                "/usr/sbin/sshd",
                "/etc/apt",
                "/bin/bash",
                "/Library/MobileSubstrate/MobileSubstrate.dylib",
                "/bin/sh",
                "/bin/su",
                "/etc/ssh/sshd_config",
                "/private/var/mobile/Library/SBSettings/Themes",
                "/private/var/mobile/Library/SBSettings",
                "/private/var/stash",
                "/var/tmp/cydia.log",
                "/var/lib/cydia",
                "/usr/libexec/ssh-keysign",
                "/var/cache/apt",
                "/var/lib/apt",
                "/etc/apt/sources.list.d",
                "/etc/apt/sources.list.d/cydia.list",
                "/usr/bin/cycript",
                "/usr/sbin/frida-server",
                "/usr/local/bin/cycript",
                "/usr/lib/libcycript.dylib",
                "/var/log/syslog",
                "/private/etc/dpkg/origins/debian",
                "/bin.sh",
                "/private/etc/apt",
                "/etc/ssh/sshd_config",
                "/private/etc/ssh/sshd_config",
                "/private/var/mobileLibrary/SBSettingsThemes/",
                "/private/var/stash",
                "/usr/libexec/cydia/",
                "/var/binpack",
                "/var/lib/dpkg/info/checkra1n.list",
                "/usr/bin/checkra1n",
                "/private/var/lib/dpkg/info",
                "/private/var/lib/dpkg/status",
                "/private/var/root/Media/Cydia",
                "/private/var/root/Media/Cydia/AutoInstall",
                "/private/var/mobile/Media/BootLogo",
                "/private/var/mobile/Media/Firmware",
        ]
    }
}

