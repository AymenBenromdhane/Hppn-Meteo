//
//  HttpManager.swift
//  Happn Weather
//
//  Created by Aymen Ben Romdhane on 24/09/2019.
//  Copyright © 2019 Aymen Ben Romdhane. All rights reserved.
//

import Foundation

import Alamofire

class HttpManager {
    
    static var sharedAlamofireManager: Alamofire.SessionManager?
    
    class func alamofireManager() -> Alamofire.SessionManager {
        if (sharedAlamofireManager != nil) {
            return sharedAlamofireManager!
        }
        
        sharedAlamofireManager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default
        )
        
        return sharedAlamofireManager!
    }
    
    /**
     * Simple Async GET request; expects JSON to be returned
     */
    class func sendGetRequest(url: String, completionHandler: @escaping (Any?, Error?) -> Void) {
        HttpManager.alamofireManager().request(url, method: .get, parameters: nil, headers: nil).response { (response) in
            
            // If there is a response, let's try to parse it as JSON
            if (response.data != nil) {
                do {
                    let data = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    completionHandler(data, nil)
                } catch {
                    completionHandler(nil, error)
                }
                
            } else {
                let code = response.response?.statusCode == nil ? -1 : response.response!.statusCode
                let error = NSError(domain: "world", code: code, userInfo: [NSLocalizedDescriptionKey : "\(code)"])
                completionHandler(nil, error)
            }
        }
    }
    
}
