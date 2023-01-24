//
//  JailbreakRootDetection.swift
//  jailbreak_root_detection
//
//  Created by M on 24/1/2566 BE.
//

import Foundation
import IOSSecuritySuite

class JailbreakRootDetection {
    
    func checkJailBroken() -> Bool {
        let isJailBroken = UIDevice.current.isJailBroken
        let amJailbroken = IOSSecuritySuite.amIJailbroken()
        let amDebugged = IOSSecuritySuite.amIDebugged()
        let amReverseEngineered = IOSSecuritySuite.amIReverseEngineered()
        let amProxied = IOSSecuritySuite.amIProxied()
        let fridaFound = FridaChecker.isFound()
        let cydiaFound = CydiaChecker.isFound()
        
        return isJailBroken
        || amJailbroken
        || amDebugged
        || amReverseEngineered
        || amProxied
        || fridaFound
        || cydiaFound
    }
    
    func checkRealDevice() -> Bool {
        let isSimulator = UIDevice.current.isSimulator
        let amEmulator = IOSSecuritySuite.amIRunInEmulator()
        
        return !isSimulator && !amEmulator
    }
    
    func checkTampered(bundleId: String) -> Bool {
        return IOSSecuritySuite.amITampered([.bundleID(bundleId)]).result
    }
}
