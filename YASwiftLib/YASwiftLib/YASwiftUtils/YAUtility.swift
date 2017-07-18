//
//  Utility.swift
//  Yashica Agrawal
//
//  Created by Yashica Agrawal on 12/21/15.
//  Copyright © 2015 Yashica Agrawal. All rights reserved.
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
            DDLogDebug("Unable to save \(key) = \(value) to user defaults")
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
            DDLogDebug("user defaults may not have been exist...")
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
        return UIImagePNGRepresentation(image)!.base64EncodedString(options: .lineLength64Characters)
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
}
