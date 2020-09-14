//
//  Utility.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import UIKit
import CocoaLumberjack

class Utility: NSObject {
    
    func deviceUUID() -> String {
        var strUUID = getUserDefault(key: Bundle.main.bundleIdentifier!) as! String
        if strUUID != "" {
            return strUUID
        } else {
            strUUID = UUID().uuidString
            setUserDefault(Bundle.main.bundleIdentifier!, value: strUUID)
            return strUUID
        }
    }
    
    // Set NSUserDefaults
    func setUserDefault(_ key:String, value:Any) {
        let defaults : AnyObject? = UserDefaults.standard
        
        if (defaults != nil) {
            defaults!.set(value, forKey: key)
        } else {
            print("Unable to save \(key) = \(value) to user defaults")
        }
    }
    
    func removeUserDefault(_ key:String) {
        let defaults : AnyObject? = UserDefaults.standard
        
        if (defaults != nil) {
            defaults!.removeObject(forKey: key)
        }
    }
    
    func removeAllUserDefault() {
        let defaults : AnyObject? = UserDefaults.standard
        
        if (defaults != nil) {
            let dict : Dictionary = (defaults?.dictionaryRepresentation())!
            for key in dict {
                defaults!.removeObject(forKey: String(describing: key))
            }
        }
    }
    
    func getUserDefault(key:String) -> AnyObject {
        var value = UserDefaults.standard.value(forKey: key)
        if value == nil {
            value = "" as AnyObject?
            print("user defaults may not have been exist...")
        }
        return value! as AnyObject
    }
    
    func checkNullObject(key : String, dict : NSDictionary) -> AnyObject {
        var value = dict.value(forKey: key)
        if(!(value is NSNull) && value != nil) {
            if (value is String) {
                return "" as AnyObject;
            } else if value is NSNull {
                return "" as AnyObject;
            }else if(value is NSArray) {
                return [AnyObject]() as AnyObject
            }
            return value! as AnyObject;
        }
        value = "";
        return value! as AnyObject;
    }
    
    func encodeToBase64String(_ image:UIImage) -> String {
        return image.pngData()!.base64EncodedString(options: .lineLength64Characters)
    }
    
    func decodeToBase64String(_ base64String:String) -> Data {
        return Data(base64Encoded: base64String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
    }
    
    func arrayEncodeToBase64String(_ arrData : NSArray? ) throws-> NSMutableArray {
        let arrStringData:NSMutableArray! = NSMutableArray()
        if arrData != nil{
            for image in arrData! {
                let objData = encodeToBase64String(image as! UIImage)
                arrStringData.add(objData)
            }
            return arrStringData
        }
        return arrStringData
    }
    
    func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func heightOfAttrbuitedText(_ width: CGFloat, string:NSMutableAttributedString) -> CGFloat {
        let rect: CGSize = string.boundingRect(with: CGSize(width: width, height: 10000), options:NSStringDrawingOptions.usesLineFragmentOrigin, context: nil).size as CGSize
        return rect.height
    }
    
    func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public func findId(first: Int, second: Int) -> Int {
        if (first == 1) {
            return 1;
        } else {
            /* The position returned by josephus(n - 1, k) is adjusted because the
             recursive call josephus(n - 1, k) considers the original position
             k%n + 1 as position 1 */
            return (findId(first: first-1, second: second) + second-1) % first + 1
        }
    }
    
    public func getDateFrom(dateTime: String?) -> Date? {
        var formattedDate: Date? = nil
        let formatter = ISO8601DateFormatter()
        if let dateTimeString = dateTime {
            formattedDate = formatter.date(from: dateTimeString)
        }
        
        if formattedDate == nil {
            if let dateTimeString = dateTime {
                let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = enUSPOSIXLocale
                dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssXXXXX"
                dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                
                let dateFormatterSubSeconds = DateFormatter()
                dateFormatterSubSeconds.locale = enUSPOSIXLocale
                dateFormatterSubSeconds.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSSSSXXXXX"
                dateFormatterSubSeconds.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                
                formattedDate = dateFormatter.date(from: dateTimeString)
                if formattedDate == nil {
                    formattedDate = dateFormatterSubSeconds.date(from: dateTimeString)
                }
            }
        }
        
        if formattedDate == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-M-dd'T'HH:mm:ss"
            dateFormatter.timeZone = NSTimeZone(name: "IST") as TimeZone?
            if let dateTimeString = dateTime {
                formattedDate = dateFormatter.date(from: dateTimeString)
            }
        }
        return formattedDate
    }
}
