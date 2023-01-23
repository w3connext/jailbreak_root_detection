import Flutter
import UIKit

public class SwiftJailbreakRootDetectionPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jailbreak_root_detection", binaryMessenger: registrar.messenger())
        let instance = SwiftJailbreakRootDetectionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
        
        UIDevice.current.isJailBroken
    }
    
    
//    let isJailBroken = UIDevice.current.isJailBroken
//                let isSimulator = UIDevice.current.isSimulator
//                let args = call.arguments
//
//                if let ignoreSimulator = args as? Bool {
//                    if ignoreSimulator && isSimulator && isJailBroken {
//                        result(false)
//                    }else{
//                        result(isJailBroken)
//                    }
//                }else{
//                    result(isJailBroken)
//                }
}
