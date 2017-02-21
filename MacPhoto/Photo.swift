//
//  Photo.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class Photo {
    
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
    var people = [String]()
    
    //MARK: Size
    var height: Pixel
    var width: Pixel
    
    var megapixels: Double { return Double(height * width) / 1_048_576 }
    
    //MARK: - Object Creation
    static func new(image: NSImage, title: String?, shortDescription: String?, longDescription: String?, dateTaken: Date?, location: Location?) {
        
        let new = Photo(image: image, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken, location: location)
        
        DataStore.instance.photos.append(new)
        LocalFileManager.instance.save(image: image, withID: new.uniqueID)
        dump(new)
    }
    
    //MARK: - Private Initializers
    private init(image: NSImage, title: String?, shortDescription: String?, longDescription: String?, dateTaken: Date?, location: Location?) {
        self.uniqueID = UniqueIDGenerator.instance.photoID
        self.dateTaken = dateTaken
        self.dateAdded = Date()
        self.location = location
        
        self.image = LocalFileManager.instance.retrieveImage(for: uniqueID)
        
        self.height = 0
        self.width = 0
    }
    
    private init(uniqueID: String, dateTaken: Date?, dateAdded: Date, location: Location?, url: URL) {
        self.uniqueID = uniqueID
        self.dateTaken = dateTaken
        self.dateAdded = dateAdded
        self.location = location
        
        self.image = LocalFileManager.instance.retrieveImage(for: uniqueID)
        
        self.height = 0
        self.width = 0
    }
}
