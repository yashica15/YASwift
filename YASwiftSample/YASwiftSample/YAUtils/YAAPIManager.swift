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
        DDLogDebug("Reachability status as : \(reachability.connection.description)")
        switch reachability.connection {
        case .cellular:
            DDLogDebug("Reachable via Cellular")
        case .wifi:
            DDLogDebug("Reachable via WiFi")
        case .unavailable:
            DDLogDebug("Network not reachable")
        case.none:
            DDLogDebug("Network unavailable")
        }
    }
        
    func getFromServer(requestURL : String, success: @escaping (_ responseObject: JSON?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        let strURL = kAPI_SERVERBASEURL + requestURL
        DDLogDebug("\nrequestURL == \(strURL)")

        (AF.request(strURL)).response { (responseData) -> Void in
            switch responseData.result {
            case .success(let value):
                let swiftyJsonVar = JSON(value as Any)
                DDLogDebug("swiftyJsonVar \(#function) : \(swiftyJsonVar)")
                success(swiftyJsonVar)
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
    
    func getFromServer(requestURL : String, completion: @escaping ((_ responseObj: APIResponse) -> Void)) {
        var strURL = kAPI_SERVERBASEURL + requestURL
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        DDLogDebug("\nrequestURL == \(strURL)")
        
        (AF.request(strURL)).response { (responseData) -> Void in
            switch responseData.result {
            case .success(let value):
                let swiftyJsonVar = JSON(value as Any)
                let objResponse = APIResponse.init(dictResp: swiftyJsonVar)
                DDLogDebug("\(objResponse ?? APIResponse.init())")
                completion(objResponse!)
            case .failure(let error):
                print(error)
                let objResponse = APIResponse.init()
                objResponse.status = false
                objResponse.message = error.localizedDescription
                completion(objResponse)
            }
        }
    }

    func postOnServer(requestURL : String, requestParameter : Dictionary <String, AnyObject>, success: @escaping (_ responseObject: JSON?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        DDLogDebug("requestParameter \(#function) : \(requestParameter)")
        let strURL = kAPI_SERVERBASEURL + requestURL
        
        AF.request(strURL, method: .post, parameters: requestParameter).response {
            (responseData) in
            switch responseData.result {
            case .success(let value):
                let swiftyJsonVar = JSON(value as Any)
                DDLogDebug("swiftyJsonVar \(#function) : \(swiftyJsonVar)")
                success(swiftyJsonVar)
            case .failure(let error):
                print(error)
                failure(error)
            }
        }
    }
    
    func postOnServer(requestURL : String, requestParameter : Dictionary <String, AnyObject>, completion: @escaping ((_ responseObj: APIResponse) -> Void) ) {
        var strURL = kAPI_SERVERBASEURL + requestURL
        strURL = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        DDLogDebug("\n requestURL == \(strURL), requestParameter == \(requestParameter)")
        
        AF.request(strURL, method: .post, parameters: requestParameter).response {
            (responseData) in
            switch responseData.result {
            case .success(let value):
                let swiftyJsonVar = JSON(value as Any)
                let objResponse = APIResponse.init(dictResp: swiftyJsonVar)
                DDLogDebug("\(objResponse ?? APIResponse.init())")
                completion(objResponse!)
            case .failure(let error):
                print(error)
                let objResponse = APIResponse.init()
                objResponse.status = false
                objResponse.message = error.localizedDescription
                completion(objResponse)
            }
        }
    }

}
