import Flutter
import UIKit

public class SwiftJailbreakRootDetectionPlugin: NSObject, FlutterPlugin {
    
    private var jailbreakRootDetection: JailbreakRootDetection? = nil
        
    init(jailbreakRootDetection: JailbreakRootDetection) {
        self.jailbreakRootDetection = jailbreakRootDetection
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jailbreak_root_detection", binaryMessenger: registrar.messenger())
        
        let jailbreakRootDetection = JailbreakRootDetection()
        
        let instance = SwiftJailbreakRootDetectionPlugin(jailbreakRootDetection: jailbreakRootDetection)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? Dictionary<String, String>
        
        switch call.method {
        case "isJailBroken":
            result(self.jailbreakRootDetection?.checkJailBroken())
            break
        case "isRealDevice":
            result(self.jailbreakRootDetection?.checkRealDevice())
            break
        case "isTampered":
            guard let bundleId = args?["bundleId"] else {
                result(FlutterError(code: "BI01", message: "Bundle ID not found", details: ""))
                return
            }
            result(self.jailbreakRootDetection?.checkTampered(bundleId: bundleId))
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
}
