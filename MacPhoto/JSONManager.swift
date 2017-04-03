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
    
    private enum PersonKey: String {
        case uniqueID = "uniqueID"
        case name = "name"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case isFemale = "isFemale"
        case photos = "photos"
    }
    
    static func save(person: Person, to dictionary: inout [String:Any]) {
        
        
        var tempDictionary = [String:Any]()
        
        tempDictionary.updateValue(person.uniqueID, forKey: PersonKey.uniqueID.rawValue)
        tempDictionary.updateValue(person.name, forKey: PersonKey.name.rawValue)
        tempDictionary.updateValue(person.firstName as Any, forKey: PersonKey.firstName.rawValue)
        tempDictionary.updateValue(person.middleName as Any, forKey: PersonKey.middleName.rawValue)
        tempDictionary.updateValue(person.lastName as Any, forKey: PersonKey.lastName.rawValue)
        tempDictionary.updateValue(person.isFemale as Any, forKey: PersonKey.isFemale.rawValue)
        tempDictionary.updateValue(person.photos, forKey: PersonKey.photos.rawValue)
        
        dictionary.updateValue(tempDictionary, forKey: person.uniqueID)
        
    }
    
    static func loadPerson(from dictionary: [String:Any]) {
        guard let uniqueID = dictionary[PersonKey.uniqueID.rawValue] as? String else { print("FAILURE: Could not parse person uniqueID"); return }
        guard let name = dictionary[PersonKey.name.rawValue] as? String else { print("FAILURE: Could not parse name for person with uniqueID: \(uniqueID)"); return }
        
        let firstName = dictionary[PersonKey.firstName.rawValue] as? String
        let middleName = dictionary[PersonKey.middleName.rawValue] as? String
        let lastName = dictionary[PersonKey.lastName.rawValue] as? String
        let isFemale = dictionary[PersonKey.isFemale.rawValue] as? Bool
        let photos = dictionary[PersonKey.photos.rawValue] as? [String:Bool] ?? [:]
        
        Person.load(uniqueID: uniqueID, name: name, firstName: firstName, middleName: middleName, lastName: lastName, isFemale: isFemale, photos: photos)
    }
}
extension JSONManager {
    //MARK: - Photo
    
    private enum PhotoKey: String {
        case uniqueID = "uniqueID"
        case title = "title"
        case shortDescription = "shortDescription"
        case longDescription = "longDescription"
        case dateAdded = "dateAdded"
        case dateTaken = "dateTaken"
        case spotID = "locationID"
        case people = "people"
    }
    
    static func save(photo: Photo, to dictionary: inout [String:Any]) {
        
        var tempDictionary = [String:Any]()
        
        tempDictionary.updateValue(photo.uniqueID, forKey: PhotoKey.uniqueID.rawValue)
        tempDictionary.updateValue(photo.title as Any, forKey: PhotoKey.title.rawValue)
        tempDictionary.updateValue(photo.shortDescription as Any, forKey: PhotoKey.shortDescription.rawValue)
        tempDictionary.updateValue(photo.longDescription as Any, forKey: PhotoKey.longDescription.rawValue)
        tempDictionary.updateValue(photo.dateAdded.standardFormatString, forKey: PhotoKey.dateAdded.rawValue)
        tempDictionary.updateValue(photo.dateTaken?.standardFormatString as Any, forKey: PhotoKey.dateTaken.rawValue)
        tempDictionary.updateValue(photo.location?.uniqueID as Any, forKey: PhotoKey.spotID.rawValue)
        tempDictionary.updateValue(photo.people, forKey: PhotoKey.people.rawValue)
        
        dictionary.updateValue(tempDictionary, forKey: photo.uniqueID)
    }
    
    static func loadPhoto(from dictionary: [String:Any]) {
        guard let uniqueID = dictionary[PhotoKey.uniqueID.rawValue] as? String else { print("FAILURE: Could not parse photo uniqueID"); return }
        
        let title = dictionary[PhotoKey.title.rawValue] as? String ?? ""
        let shortDescription = dictionary[PhotoKey.shortDescription.rawValue] as? String
        let longDescription = dictionary[PhotoKey.longDescription.rawValue] as? String
        let dateTakenString = dictionary[PhotoKey.dateTaken.rawValue] as? String ?? ""
        let dateTaken = Date.from(standardFormatString: dateTakenString)
        let dateAddedString = dictionary[PhotoKey.dateAdded.rawValue] as? String ?? ""
        let dateAdded = Date.from(standardFormatString: dateAddedString) ?? Date()
        let locationID = dictionary[PhotoKey.spotID.rawValue] as? String ?? ""
        let location = Spot.with(uniqueID: locationID)
        let people = dictionary[PhotoKey.people.rawValue] as? [String:Bool] ?? [:]
        
        Photo.load(uniqueID: uniqueID, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken, location: location, dateAdded: dateAdded, people: people)
    }
    
}
