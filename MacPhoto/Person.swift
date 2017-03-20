//
//  Person.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/21/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class Person: HasUniqueID {
    
    //MARK: - Stored Properties
    var uniqueID: String
    
    var name: String
    var firstName: String?
    var middleName: String?
    var lastName: String?
    
    var isFemale: Bool?
    
    var photos = [String:Bool]()
    
    //MARK: Object Creation
    static func new(name:String, firstName: String?, middleName: String?, lastName: String?, isFemale: Bool? = nil) {
        let new = Person(name: name, firstName: firstName, middleName: middleName, lastName: lastName)
    
        DataStore.instance.people.add(new)
        newest = new
    }
    
    static func load(uniqueID: String, name: String, firstName: String?, middleName: String?, lastName: String?) {
        let new = Person(uniqueID: uniqueID, name: name, firstName: firstName, middleName: middleName, lastName: lastName)
        
        DataStore.instance.people.add(new)
    }
    
    //MARK: Private Initializers
    private init(name: String, firstName: String?, middleName: String?, lastName: String?) {
        uniqueID = UniqueIDGenerator.instance.personID
        self.name = name
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
    
    private init(uniqueID: String, name: String, firstName: String?, middleName: String?, lastName: String?) {
        self.uniqueID = uniqueID
        self.name = name
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
    
    static var newest: Person?
    
}

extension Person {
    
    //MARK: - Name
    
    var fullName: String {
        var fullName = ""
        
        if let firstName = firstName {
            fullName += firstName
            
            if firstName != name {
                fullName += " \"\(name)\""
            }
        } else {
            fullName += name
        }
        
        if let middleName = middleName {
            fullName += " " + middleName
        }
        
        if let lastName = lastName {
            fullName += " " + lastName
        }
        
        return fullName
    }
    
}
