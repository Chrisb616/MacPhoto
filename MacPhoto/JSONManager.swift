//
//  JSONManager.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/4/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

struct JSONManager {
    
    private init() {}
}
extension JSONManager {
    //MARK: - Person

    private static var uniqueIDKey = "uniqueID"
    private static var nameKey = "name"
    private static var firstNameKey = "firstName"
    private static var middleNameKey = "middleName"
    private static var lastNameKey = "lastName"
    
    static func save(person: Person, to dictionary: inout [String:Any]) {
        
        
        var tempDictionary = [String:Any]()

        tempDictionary.updateValue(person.uniqueID, forKey: uniqueIDKey)
        tempDictionary.updateValue(person.name, forKey: nameKey)
        tempDictionary.updateValue(person.firstName as Any, forKey: firstNameKey)
        tempDictionary.updateValue(person.middleName as Any, forKey: middleNameKey)
        tempDictionary.updateValue(person.lastName as Any, forKey: lastNameKey)
        
        dictionary.updateValue(tempDictionary, forKey: person.uniqueID)
        
    }
    
    static func loadPerson(from dictionary: [String:Any]) {
        guard let uniqueID = dictionary[uniqueIDKey] as? String else { print("FAILURE: Could not parse uniqueID"); return }
        guard let name = dictionary[nameKey] as? String else { print("FAILURE: Could not parse name for person with uniqueID: \(uniqueID)"); return }
        
        let firstName = dictionary[firstNameKey] as? String
        let middleName = dictionary[middleNameKey] as? String
        let lastName = dictionary[lastNameKey] as? String
        
        Person.load(uniqueID: uniqueID, name: name, firstName: firstName, middleName: middleName, lastName: lastName)
    }
}
extension JSONManager {
    //MARK: - Photo
    
    private static var uniqueIDKey = "uniqueID"
    private static var titleKey = "title"
    private static var shortDescriptionKey = "shortDescription"
    private static var longDescriptionKey = "longDescription"
    private static var dateAddedKey = "dateAdded"
    private static var dateTakenKey = "dateTaken"
    private static var spotIDKey = "spotID"
    private static var peopleKey = "people"

    static func save(photo: Photo, to dictionary: inout [String:Any]) {
        
        var tempDictionary = [String:Any]()
        
        tempDictionary.updateValue(photo.uniqueID, forKey: uniqueIDKey)
        tempDictionary.updateValue(photo.title as Any, forKey: titleKey)
        tempDictionary.updateValue(photo.shortDescription as Any, forKey: shortDescriptionKey)
        tempDictionary.updateValue(photo.longDescription as Any, forKey: longDescriptionKey)
        tempDictionary.updateValue(photo.dateAdded.standardFormatString, forKey: dateAddedKey)
        tempDictionary.updateValue(photo.dateTaken?.standardFormatString as Any, forKey: dateTakenKey)
        tempDictionary.updateValue(photo.spot?.uniqueID as Any, forKey: spotIDKey)
        tempDictionary.updateValue(photo.people, forKey: peopleKey)
    }
    
    static func loadPhoto(from dictionary: [String:Any]) {
        guard let uniqueID = dictionary[uniqueIDKey] as? String else { print("FAILURE: Could not parse uniqueID"); return }
        
        let title = dictionary[titleKey] as? String
        let shortDescription = dictionary[shortDescriptionKey] as? String
        let longDescription = dictionary[longDescriptionKey] as? String
        let dateTakenString = dictionary[dateTakenKey] as? String ?? ""
        let dateTaken = Date.from(standardFormatString: dateTakenString)
        let dateAddedString = dictionary[dateAddedKey] as? String ?? ""
        let dateAdded = Date.from(standardFormatString: dateAddedString) ?? Date()
        let spotID = dictionary[spotIDKey] as? String ?? ""
        let spot = DataStore.instance.spots.with(uniqueID: spotID)
        let people = dictionary[peopleKey] as? [String:Bool] ?? [:]
        
        Photo.load(uniqueID: uniqueID, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken, spot: spot, dateAdded: dateAdded, people: people)
    }
    
}
