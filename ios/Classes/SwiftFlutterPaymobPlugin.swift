import Flutter
import UIKit

public class SwiftFlutterPaymobPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_paymob", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterPaymobPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let methodName = call.method
        let args = call.arguments as? Dictionary<String, Any>
        switch methodName {
        case "StartPayActivityNoToken":
            SwiftFlutterPaymobPlugin.startPayActivityNoToken(args!, result)
            break
        case "StartPayActivityToken":
            SwiftFlutterPaymobPlugin.startPayActivityToken(args!, result)
            break
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
            break
        default:
            result(FlutterError(code: "UNIMPLEMENTED",
                                message: "\(methodName) is not implemented",
                                details: nil))
            break
        }
    }
    
    static func startPayActivityNoToken(_ args: Dictionary<String, Any>, _ result: @escaping FlutterResult) {
        
    }
    
    static func startPayActivityToken(_ args: Dictionary<String, Any>, _ result: @escaping FlutterResult) {
        
    }
}
