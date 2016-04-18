//
//  User.swift
//  10CloudsProject
//
//  Created by Dominik Reczek on 15/03/16.
//  Copyright © 2016 Dominik Reczek. All rights reserved.
//

import UIKit

enum Gender : Int {
    case Male = 0
    case Female
    case Undefined
}

struct Location {
    var street : String = ""
    var city : String = ""
    var state : String = ""
}

class User: NSObject {
    var name : String?
    var username : String?
    var email : String?
    var cellNumber : String?
    var picture : String?
    var createdAt : String?
    var gender : Gender?
    var location : Location?
    
    init(json : JSON) {
        super.init()
        
        self.name = self.getNameFromJSON(json)
        self.username = json["login"]["username"].stringValue
        self.email = json["email"].stringValue
        self.cellNumber = json["phone"].stringValue
        self.picture = json["picture"]["medium"].stringValue
        self.gender = self.determineGender(json)
        self.location = self.determineLocation(json)
        self.createdAt = self.getCurrentTime()
    }
    
    func getCurrentTime() -> String {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        
        var minutesAsString : String
        if minutes < 10 {
            minutesAsString = "0\(minutes)"
        } else {
            minutesAsString = "\(minutes)"
        }
        return "\(hour):\(minutesAsString)"
    }
    
    func getNameFromJSON(json : JSON) -> String {
        if let nameJSON : [String : JSON] = json["name"].dictionaryValue {
            
            var title : String = ""
            if let titleFromJSON = nameJSON["title"]?.stringValue.uppercaseFirst {
                title = titleFromJSON
            }
            
            var first : String = ""
            if let firstFromJSON = nameJSON["first"]?.stringValue.uppercaseFirst {
                first = firstFromJSON
            }
            
            var last : String = ""
            if let lastFromJSON = nameJSON["last"]?.stringValue.uppercaseFirst {
                last = lastFromJSON
            }
            
            return "\(title) \(first) \(last)"
        }
        
        return ""
    }
    
    func determineGender(json : JSON) -> Gender {
        var gender : Gender
        let genderFromJSON = json["gender"].stringValue
        if genderFromJSON == "male" {
            gender = .Male
        } else if genderFromJSON == "female" {
            gender = .Female
        } else {
            gender = .Undefined
        }
        
        return gender
    }
    
    func determineLocation(json : JSON) -> Location {
        if let locationJSON : [String : JSON] = json["location"].dictionaryValue {
            var street : String = ""
            if let streetFromJSON : String = locationJSON["street"]?.stringValue {
                street = streetFromJSON
            }
            
            var city : String = ""
            if let cityFromJSON : String = locationJSON["city"]?.stringValue {
                city = cityFromJSON
            }
            
            var state : String = ""
            if let stateFromJSON : String = locationJSON["state"]?.stringValue {
                state = stateFromJSON
            }
            
            let location = Location(street: street, city: city, state: state)
            return location
        }
        
        return Location()
    }
}
