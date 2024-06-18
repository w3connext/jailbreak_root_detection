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
        let amReverseEngineered = ReverseEngineeringChecker.amIReverseEngineered()
        let amProxied = IOSSecuritySuite.amIProxied()
        let fridaFound = FridaChecker.isFound()
        let cydiaFound = CydiaChecker.isFound()
        
        return isJailBroken
        || amJailbroken
        || amReverseEngineered
        || amProxied
        || fridaFound
        || cydiaFound
    }

    func checkJail() -> Bool {
        let isJailBroken = UIDevice.current.isJailBroken
        let amJailbroken = IOSSecuritySuite.amIJailbroken()
        
        return isJailBroken
        || amJailbroken
    }

    func checkDebugged() -> Bool {
        return IOSSecuritySuite.amIDebugged()
    }

    func checkReverseEngineered() -> Bool {
        return ReverseEngineeringChecker.amIReverseEngineered()
    }

    func checkProxied() -> Bool {
        return IOSSecuritySuite.amIProxied()
    }

    func checkFrida() -> Bool {
        return FridaChecker.isFound()
    }

    func checkCydia() -> Bool {
        return CydiaChecker.isFound()
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
