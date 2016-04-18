//
//  RestApiManager.swift
//  10CloudsProject
//
//  Created by Dominik Reczek on 3/5/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON?, NSError?) -> Void

class RestApiManager: NSObject {
    private let apiURL = "http://api.randomuser.me?results="

    func generateRandomUsers(count users: Int, onCompletion: (JSON) -> Void) {
        
        let route = "\(self.apiURL)\(users)"
        self.makeHTTPGetRequest(route, onCompletion: { json, err in
            if let error = err {
                self.printError(error)
                onCompletion(nil)
            } else {
                onCompletion(json! as JSON)
            }
        })
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, err -> Void in
            
            if let error = err {
                self.printError(error)
                onCompletion(nil, error)
            } else {
                let json:JSON = JSON(data: data!)
                onCompletion(json, nil)
            }
        })
        
        task.resume()
    }
    
    func printError(error : NSError) {
        print("Error: \(error.code)")
    }
}
