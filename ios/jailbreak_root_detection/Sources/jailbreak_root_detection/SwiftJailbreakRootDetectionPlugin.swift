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
        case "checkForIssues":
            var issues = [String]()
            if self.jailbreakRootDetection?.checkJail() == true {
                issues.append("jailbreak")
            }

            if self.jailbreakRootDetection?.checkDebugged() == true {
                issues.append("debugged")
            }

            if self.jailbreakRootDetection?.checkReverseEngineered() == true {
                issues.append("reverseEngineered")
            }

            if self.jailbreakRootDetection?.checkProxied() == true {
                issues.append("proxied")
            }

            if self.jailbreakRootDetection?.checkFrida() == true {
                issues.append("fridaFound")
            }

            if self.jailbreakRootDetection?.checkCydia() == true {
                issues.append("cydiaFound")
            }

            if self.jailbreakRootDetection?.checkRealDevice() == false {
                issues.append("notRealDevice")
            }

            result(issues)
            break
        case "isJailBroken":
            result(self.jailbreakRootDetection?.checkJailBroken())
            break
        case "isRealDevice":
            result(self.jailbreakRootDetection?.checkRealDevice())
            break
        case "isDebugged":
            result(self.jailbreakRootDetection?.checkDebugged())
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
