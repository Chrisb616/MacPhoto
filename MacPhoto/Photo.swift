//
//  Photo.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class Photo: HasUniqueID {
    
    //MARK: - Properties
    
    //MARK: Unique ID
    var uniqueID: String
    
    //MARK: Image
    var image: NSImage
    
    //MARK: Story Info
    var title: String
    var shortDescription: String?
    var longDescription: String?
    
    //MARK: Date
    var dateTaken: Date?
    var dateAdded: Date
    
    //MARK: Spot
    var location: Location? { return safeLocation }
    weak var safeLocation: Location?
    
    //MARK: People
    var people: [String:Bool] { return safePeople }
    private var safePeople = [String:Bool]()
    
    //MARK: - Computed Properties
    
    //MARK: Size
    var size: CGSize { return image.size }
    
    var height: CGFloat { return size.height }
    var width: CGFloat { return size.width }
    
    var megapixels: Double { return Double(height * width) / 1_048_576 }
    
    //MARK: - Access Through ID
    static func with(uniqueID: String) -> Photo? {
        if let photo = DataStore.instance.photos.with(uniqueID: uniqueID) {
            return photo
        } else {
            print("WARNING: Photo not found for unique ID: \(uniqueID)")
            return nil
        }
    }
    
    //MARK: - Object Creation
    static func new(image: NSImage, title: String, shortDescription: String?, longDescription: String?, dateTaken: Date?, location: Location?) {
        
        let new = Photo(image: image, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken)
        if let location = location {
            new.associate(location: location)
        }
        
        DataStore.instance.photos.add(new)
        LocalFileManager.instance.save(image: image, withID: new.uniqueID)
    }
    
    static func load(uniqueID: String, title: String, shortDescription: String?, longDescription: String?, dateTaken: Date?, location: Location?, dateAdded: Date, people: [String:Bool]) {
    
        let new = Photo(uniqueID: uniqueID, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken, dateAdded: dateAdded, people: people)
        if let location = location {
            new.associate(location: location)
        }
        
        DataStore.instance.photos.add(new)
    }
    
    //MARK: - Private Initializers
    
    //New
    private init(image: NSImage, title: String, shortDescription: String?, longDescription: String?, dateTaken: Date?) {
        self.uniqueID = UniqueIDGenerator.instance.photoID
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.dateTaken = dateTaken
        self.dateAdded = Date()
        
        self.image = image
    }
    
    //Load
    private init(uniqueID: String, title: String, shortDescription: String?, longDescription: String?, dateTaken: Date?, dateAdded: Date, people: [String:Bool]) {
        self.uniqueID = uniqueID
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.dateTaken = dateTaken
        self.dateAdded = dateAdded
        
        self.image = LocalFileManager.instance.load(imageWithID: uniqueID) ?? NSImage()
        
        self.safePeople = people
    }

    //MARK: - Update Associations
    
    //MARK: Person
    func associate(personWithID uniqueID: String) {
        guard let person = DataStore.instance.people.with(uniqueID: uniqueID) else { print("WARNING: Person not found for unique ID: \(uniqueID)"); return }
        person.photos.updateValue(true, forKey: self.uniqueID)
        self.safePeople.updateValue(true, forKey: person.uniqueID)
    }
    
    func associate(person: Person) {
        person.photos.updateValue(true, forKey: self.uniqueID)
        self.safePeople.updateValue(true, forKey: person.uniqueID)
    }
    
    func disassociate(personWithID uniqueID: String) {
        if let person = DataStore.instance.people.with(uniqueID: uniqueID) {
            person.photos.removeValue(forKey: self.uniqueID)
        } else {
            print("WARNING: Person not found for unique ID: \(uniqueID)")
        }
        
        if self.people[uniqueID] == nil {
            print("WARNING: Person for unqiueID: \(uniqueID) not found to be associated with photo")
        } else {
            safePeople.removeValue(forKey: uniqueID)
        }
    }
    
    func disassociate(person: Person) {
        person.photos.removeValue(forKey: self.uniqueID)
        
        if self.people[person.uniqueID] == nil {
            print("WARNING: Person for unqiueID: \(person.uniqueID) not found to be associated with photo")
        } else {
            safePeople.removeValue(forKey: person.uniqueID)
        }
    }
    
    //MARK: Spot
    func associate(spotWithUniqueID uniqueID: String) {
        if location != nil { disassociateSpot() }
        
        guard let location = Spot.withID(uniqueID) else { print("WARNING: Location not found for uniqueID: \(uniqueID)"); return }
        location.photos.updateValue(true, forKey: self.uniqueID)
        safeLocation = location
    }
    
    func associate(location: Location) {
        if self.location != nil { disassociateSpot() }
        
        location.photos.updateValue(true, forKey: self.uniqueID)
        safeLocation = location
    }
    
    func disassociateSpot() {
        if let location = self.location {
            location.photos.removeValue(forKey: self.uniqueID)
            self.safeLocation = nil
        } else {
            print("WARNING: No spot found which to dissociate with.")
        }
    }

}
