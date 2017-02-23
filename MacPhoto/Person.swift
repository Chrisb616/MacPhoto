//
//  Person.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/21/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class Person {
    
    let uniqueID: String
    
    var name: String
    var firstName: String?
    var middleName: String?
    var lastName: String?
    
    var photos = [String:Bool]()
    
    var data: PersonData
    
    static func new(name:String) -> Person {
        let person = Person(name: name)
        let data = PersonData(person)
        
        person.data = data
        
        return person
    }
    
    private init(name: String) {
        uniqueID = UniqueIDGenerator.instance.personID
        self.name = name
        self.data = PersonData()
    }
    init(uniqueID: String, name: String, firstName: String?, middleName: String?, lastName: String?) {
        self.uniqueID = uniqueID
        self.name = name
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.data = PersonData()
    }
    
}
