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
        let new = Person(name: name, firstName: firstName, middleName: middleName, lastName: lastName, isFemale: isFemale)
    
        DataStore.instance.people.add(new)
        newest = new
        LocalFileManager.instance.savePersonInfo()
    }
    
    static func load(uniqueID: String, name: String, firstName: String?, middleName: String?, lastName: String?, isFemale: Bool?, photos: [String:Bool]) {
        let new = Person(uniqueID: uniqueID, name: name, firstName: firstName, middleName: middleName, lastName: lastName, isFemale: isFemale)
        
        new.photos = photos
        
        DataStore.instance.people.add(new)
    }
    
    //MARK: Private Initializers
    private init(name: String, firstName: String?, middleName: String?, lastName: String?, isFemale: Bool?) {
        uniqueID = UniqueIDGenerator.instance.personID
        self.name = name
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
    
    private init(uniqueID: String, name: String, firstName: String?, middleName: String?, lastName: String?, isFemale: Bool?) {
        self.uniqueID = uniqueID
        self.name = name
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.isFemale = isFemale
    }
    
    static var newest: Person?
    
}

extension Person {
    
    
    var allPhotos: [Photo] {
        var allPhotos = [Photo]()
        let store = DataStore.instance
        
        for uniqueID in photos.keys {
            guard let photo = store.photos.with(uniqueID: uniqueID) else { continue }
            
            allPhotos.append(photo)
        }
        
        return allPhotos
    }
    
    var randomPhoto: Photo? {
        let store = DataStore.instance
        
        for uniqueID in photos.keys {
            guard let photo = store.photos.with(uniqueID: uniqueID) else { continue }
            
            return photo
        }
        
        return nil
    }
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
