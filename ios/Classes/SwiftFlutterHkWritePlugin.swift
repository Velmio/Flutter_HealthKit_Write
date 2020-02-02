import Flutter
import UIKit
import HealthKit

public class SwiftFlutterHkWritePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_hk_write", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterHkWritePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
  private var healthStore: HKHealthStore? = nil;

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    //result("iOS " + UIDevice.current.systemVersion)
    
    guard HKHealthStore.isHealthDataAvailable() else {
        result(FlutterError(code: "flutter_hk_write", message: "Not supported", details: nil))
        return
    }

    if (healthStore == nil) {
        healthStore = HKHealthStore();
    }
    
    do {
       if (call.method == "requestWritePermissions") {
            requestWritePermissions(result: result)
       }
       else if (call.method == "writeSleepEntry") {
        
        guard
            let arguments = call.arguments as? Dictionary<String, Any>,
            let from = arguments["from"] as? Int,
            let to = arguments["to"] as? Int
            else {
                print("invalid call arguments")
                return
        }
        
        
        
            writeSleepEntry(value: "inBed", from: Date(timeIntervalSince1970: Double(from)), to: Date(timeIntervalSince1970: Double(to)), result: result)
       }
       else {
            result(FlutterMethodNotImplemented)
        }
    }
    catch {
        result(FlutterError(code: "flutter_hk_write", message: "Error \(error)", details: nil))
    }
    
  }
    
    func requestWritePermissions(result: @escaping FlutterResult) {
        
        //Test Data Types
        
        let typestoRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
               ])
        
        let typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
               ])
        
        healthStore!.requestAuthorization(toShare: typestoShare, read: typestoRead) { (success, error) -> Void in
            if success == false {
                NSLog(" Display not allowed")
                result(false)
            } else {
                result(true)
            }
        }
    }
    
    
    func writeSleepEntry(value: String, from: Date, to: Date, result: @escaping FlutterResult) {
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
           
            let object = HKCategorySample(type: sleepType, value: HKCategoryValueSleepAnalysis.inBed.rawValue, start: from, end: to)
            
            healthStore!.save(object, withCompletion: { (success, error) -> Void in
                
                if error != nil {
                    // something happened
                    result(false)
                    return
                }
                
                if success {
                    print("My new data was saved in HealthKit")
                    result(true)
                    
                } else {
                    // something happened again
                    result(false)
                }
                
            })
        }
    }
    
    func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
        return calendar.date(from: components)!
    }

    
    
}

