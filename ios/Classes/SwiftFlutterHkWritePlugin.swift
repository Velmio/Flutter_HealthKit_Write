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
       } else if (call.method == "writeQuantityEntries") {
         
        guard
         let arguments = call.arguments as? Dictionary<String, Any>,
         let entries = arguments["entries"] as? [[String: Any]]
        else {
            print("invalid call arguments")
            return
         }
        writeQuantityTypes(types: entries, result: result)
        
       }
       else {
            result(FlutterMethodNotImplemented)
        }
    }
// Reactivate Catch if addtional throw's are needed
//    catch {
//        result(FlutterError(code: "flutter_hk_write", message: "Error \(error)", details: nil))
//    }
    
  }
    
    func requestWritePermissions(result: @escaping FlutterResult) {
        
        //Test Data Types
        
        var typestoRead = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatTotal)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCarbohydrates)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatSaturated)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFiber)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCalcium)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryIron)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryPotassium)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminA)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminC)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminD)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
            
            
               ])
        
        if #available(iOS 9.0, *) {
            typestoRead.insert(            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!)
        } else {
            // Fallback on earlier versions
        }
        
        
        var typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatTotal)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCarbohydrates)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatSaturated)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFiber)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCalcium)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryIron)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryPotassium)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminA)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminC)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminD)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
            
               ])
        
        if #available(iOS 9.0, *) {
                  typestoShare.insert(            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!)
              } else {
                  // Fallback on earlier versions
        }
              
        
        healthStore!.requestAuthorization(toShare:typestoShare, read: typestoRead) { (success, error) -> Void in
            if success == false {
                NSLog(" Display not allowed")
                result(false)
            } else {
                result(true)
            }
        }
    }
    
    //Legacy Test Function
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
    
    func parseType(typeKey: String) -> HKObjectType? {
        switch typeKey {
        case "Fat":
            return  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatTotal)
        case "Protein":
        return  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryProtein)
        case "Carbohydrate":
        return  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCarbohydrates)
        case "Water":
            if #available(iOS 9.0, *) {
                return  HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)
            } else {
                // Fallback on earlier versions
                return nil
            }
        case "Sleep":
            return HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)
        //New Units
        case "Energy":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryEnergyConsumed)
        case "Saturated fat":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFatSaturated)
        case "Cholesterol":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCholesterol)
        case "Fiber":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryFiber)
        case "Sugar":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySugar)
        case "Calcium, Ca":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryCalcium)
        case "Iron, Fe":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryIron)
        case "Potassium, K":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryPotassium)
        case "Sodium, Na":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietarySodium)
        case "Vitamin A":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminA)
        case "Vitamin C":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminC)
        case "Vitamin D":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryVitaminD)
        //Weight
         case "Body Mass":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
        default:
            return nil
        }
    }
    
    func parseUnit(unitRaw: String) -> HKUnit? {
        switch unitRaw {
            case "kg":
                return HKUnit.gramUnit(with: .kilo)
            case "pounds":
                return HKUnit.pound()
            case "liter":
                return HKUnit.liter()
            case "G":
                return HKUnit.gram()
            case "KCAL":
                return HKUnit.kilocalorie()
            case "MG":
                return HKUnit.gramUnit(with: .milli)
            case "UG":
                return HKUnit.gramUnit(with: .micro)
            default:
                return nil
            }
    }
    
    //TODO: Adapt for other datatypes in HK
    func writeQuantityTypes(types: [[String: Any]], result: @escaping FlutterResult){
        for type in types {
            
            //Parse input
            
            guard
            let value = type["value"] as? Double,
            let fromRaw = type["from"] as? Int,
            let toRaw = type["to"] as? Int,
            let typeKey = type["type"] as? String,
            let unitRaw = type["unit"] as? String
            else {
                result(FlutterError(code: "flutter_hk_write", message: "Incorrect input", details: nil))
               return
            }
            
            let from = Date(timeIntervalSince1970: Double(fromRaw))
            let to = Date(timeIntervalSince1970: Double(toRaw))
            let identifier = parseType(typeKey: typeKey)
            let unit = parseUnit(unitRaw: unitRaw)
            
            
            
            if let healthKitType = identifier {
                      
                        let object = HKQuantitySample(type: healthKitType as! HKQuantityType, quantity: HKQuantity(unit: unit!, doubleValue: value), start: from, end: to)
                
                                            
                        healthStore!.save(object, withCompletion: { (success, error) -> Void in
                            
                            if error != nil {
                                // something happened
                                result(FlutterError(code: "flutter_hk_write", message: "Error: \(String(describing: error))", details: nil))
                                return
                                
                            }
                            
                            if success {
                                print("My new data was saved in HealthKit")
                                result(true)
                                
                            } else {
                                // something happened again
                                result(FlutterError(code: "flutter_hk_write", message: "Unable to save", details: nil))
                            }
                            
                        })
                       
                
                   }
        }
    }
    
    func makeDate(year: Int, month: Int, day: Int, hr: Int, min: Int, sec: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        // calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let components = DateComponents(year: year, month: month, day: day, hour: hr, minute: min, second: sec)
        return calendar.date(from: components)!
    }

    
    
}

