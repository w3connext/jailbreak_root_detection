import Flutter
import UIKit
import IOSSecuritySuite

public class SwiftJailbreakRootDetectionPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jailbreak_root_detection", binaryMessenger: registrar.messenger())
        let instance = SwiftJailbreakRootDetectionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isJailBroken":
            result(checkJailBroken())
            break
        case "isRealDevice":
            result(checkRealDevice())
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func checkJailBroken() -> Bool {
        let isJailBroken = UIDevice.current.isJailBroken
        let amJailbroken = IOSSecuritySuite.amIJailbroken()
        let amDebugged = IOSSecuritySuite.amIDebugged()
        let amReverseEngineered = IOSSecuritySuite.amIReverseEngineered()
        let amProxied = IOSSecuritySuite.amIProxied()
        let fridaFound = FridaChecker.isFound()
        let cydiaFound = CydiaChecker.isFound()
        
        print("isJailBroken: \(isJailBroken)")
        print("amJailbroken: \(amJailbroken)")
        print("amDebugged: \(amDebugged)")
        print("amReverseEngineered: \(amReverseEngineered)")
        print("amProxied: \(amProxied)")
        
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
        
        print("isSimulator: \(isSimulator)")
        print("amEmulator: \(amEmulator)")
        
        return !isSimulator && !amEmulator
    }
    
}
