//
//  YAAPIManager.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CocoaLumberjack
import Reachability

class APIManager {
    
    var delegate :AnyObject?
    var callbackSelector : Selector?
    
    //MARK: Shared Instance
    static let apiManager: APIManager = APIManager()
    
    /*!
     @brief Created By   : Yashica
     @brief Date         : 23-Dec-2017
     @brief Description  : Sends Asynchronous POST request on input URL and respond back to call back selector method.
     @brief Update by    : --
     @brief Update Date  : --
     @brief Reason       : Method to send POST request to server and respond back call back selector.
     */
    func initWithDelegate(_ aDelegate : AnyObject,aCallbackSel : Selector) -> AnyObject {
        
        self.delegate = aDelegate;
        self.callbackSelector = aCallbackSel;
        
        return self
    }
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                DDLogDebug("Reachable via WiFi")
            } else {
                DDLogDebug("Reachable via Cellular")
            }
        } else {
            DDLogDebug("Network not reachable")
        }
    }
    
    func getFromServer(requestURL : String, completion: ((_ responseObj: JSON?) -> Void)?) {
        let URL = kAPI_SERVERBASEURL + requestURL
                
        (AF.request(URL)).response { (responseData) -> Void in
//            if let json = responseData.result.value {
//                let swiftyJsonVar = JSON(json)
//                DDLogDebug("swiftyJsonVar \(#function) : \(swiftyJsonVar)")
//                completion!(swiftyJsonVar)
//            }
        }
    }
    
    func getFromServer(requestURL : String, completion: @escaping ((_ responseObj: APIResponse) -> Void)) {
        var strURL = kAPI_SERVERBASEURL + requestURL
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        DDLogDebug("\nrequestURL == \(strURL)")
//        Alamofire.request(strURL).responseJSON { (responseData) -> Void in
//            if (responseData.result.error != nil) {
//                let objResponse = APIResponse.init()
//                objResponse.status = false
//                objResponse.message = responseData.result.error?.localizedDescription
//                completion(objResponse)
//            } else {
//                if((responseData.result.value) != nil) {
//                    let swiftyJsonVar = JSON(responseData.result.value!)
//                    let objResponse = APIResponse.init(dictResp: swiftyJsonVar)
//                    DDLogDebug("\(objResponse ?? APIResponse.init())")
//                    completion(objResponse!)
//                }
//            }
//        }
    }

    func postOnServer(requestURL : String, requestParameter : Dictionary <String, AnyObject>, completion: @escaping ((_ responseObj: JSON?) -> Void) ) {
        DDLogDebug("requestParameter \(#function) : \(requestParameter)")

        let URL = kAPI_SERVERBASEURL + requestURL
//        Alamofire.request(URL, method: .post, parameters: requestParameter, encoding: JSONEncoding.default)
//            .responseJSON {
//                responseData in
//                if let json = responseData.result.value {
//                    let swiftyJsonVar = JSON(json)
//                    DDLogDebug("swiftyJsonVar \(#function) : \(swiftyJsonVar)")
//                    completion(swiftyJsonVar)
//                }
//        }
    }
    
    func postOnServer(requestURL : String, requestParameter : Dictionary <String, AnyObject>, completion: @escaping ((_ responseObj: APIResponse) -> Void) ) {
        var strURL = kAPI_SERVERBASEURL + requestURL
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        DDLogDebug("\n requestURL == \(strURL), requestParameter == \(requestParameter)")
//        Alamofire.request(strURL, method: .post, parameters: requestParameter, encoding: JSONEncoding.default)
//            .responseJSON { responseData in
//                if (responseData.result.error != nil) {
//                    let objResponse = APIResponse.init()
//                    objResponse.status = false
//                    objResponse.message = responseData.result.error?.localizedDescription
//                    completion(objResponse)
//                } else {
//                    if((responseData.result.value) != nil) {
//                        let swiftyJsonVar = JSON(responseData.result.value!)
//                        let objResponse = APIResponse.init(dictResp: swiftyJsonVar)
//                        DDLogDebug("\(objResponse ?? APIResponse.init())")
//                        completion(objResponse!)
//                    }
//                }
//        }
    }

}
