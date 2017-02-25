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
    var title: String?
    var shortDescription: String?
    var longDescription: String?
    
    //MARK: Date
    var dateTaken: Date?
    var dateAdded: Date
    
    //MARK: Location
    var location: Location?
    
    //MARK: People
    var people = [String:Bool]()
    
    //MARK: Size
    var height: Pixel
    var width: Pixel
    
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
    static func new(image: NSImage, title: String?, shortDescription: String?, longDescription: String?, dateTaken: Date?, location: Location?) {
        
        let new = Photo(image: image, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken, location: location)
        
        DataStore.instance.photos.add(new)
        LocalFileManager.instance.save(image: image, withID: new.uniqueID)
    }
    
    static func load(uniqueID: String, title: String?, shortDescription: String?, longDescription: String?, dateTaken: Date?, location: Location?, dateAdded: Date) {
    
        let new = Photo(uniqueID: uniqueID, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken, dateAdded: dateAdded, location: location)
        
        DataStore.instance.photos.add(new)
    }
    
    //MARK: - Private Initializers
    private init(image: NSImage, title: String?, shortDescription: String?, longDescription: String?, dateTaken: Date?, location: Location?) {
        self.uniqueID = UniqueIDGenerator.instance.photoID
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.dateTaken = dateTaken
        self.dateAdded = Date()
        self.location = location
        
        self.image = LocalFileManager.instance.load(imageWithID: uniqueID) ?? NSImage()
        
        self.height = 0
        self.width = 0
    }
    
    private init(uniqueID: String, title: String?, shortDescription: String?, longDescription: String?, dateTaken: Date?, dateAdded: Date, location: Location?) {
        self.uniqueID = uniqueID
        self.title = title
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.dateTaken = dateTaken
        self.dateAdded = dateAdded
        self.location = location
        
        self.image = LocalFileManager.instance.load(imageWithID: uniqueID) ?? NSImage()
        
        self.height = 0
        self.width = 0
    }

}
