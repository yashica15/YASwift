//
//  APIManager.swift
//  Yashica Agrawal
//
//  Created by Yashica Agrawal on 12/22/15.
//  Copyright © 2015 Yashica Agrawal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CocoaLumberjack

class APIManager {
    
    var delegate :AnyObject?
    var callbackSelector : Selector?
    
    //MARK: Shared Instance
    static let apiManager: APIManager = APIManager()
    
    /*!
     @brief Created By   : Yashica
     @brief Date         : 23-Dec-2015
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
    
    func getFromServer(requestURL : String, completion: ((_ responseObj: JSON?) -> Void)?) {
        let URL = kAPI_SERVERBASEURL + requestURL
        Alamofire.request(URL).responseJSON { (responseData) -> Void in
            if let json = responseData.result.value {
                let swiftyJsonVar = JSON(json)
                DDLogDebug("swiftyJsonVar \(#function) : \(swiftyJsonVar)")
                completion!(swiftyJsonVar)
            }
        }
    }
    
    func postOnServer(requestURL : String, requestParameter : Dictionary <String, AnyObject>, completion: @escaping ((_ responseObj: JSON?) -> Void) ) {
        DDLogDebug("requestParameter \(#function) : \(requestParameter)")

        let URL = kAPI_SERVERBASEURL + requestURL
        Alamofire.request(URL, method: .post, parameters: requestParameter, encoding: JSONEncoding.default)
            .responseJSON {
                responseData in
                if let json = responseData.result.value {
                    let swiftyJsonVar = JSON(json)
                    DDLogDebug("swiftyJsonVar \(#function) : \(swiftyJsonVar)")
                    completion(swiftyJsonVar)
                }
        }
    }

}
