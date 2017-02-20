//
//  Photo.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class Photo {
    
    var uniqueID: String
    
    var image: NSImage
    
    var dateTaken: Date?
    var dateAdded: Date
    
    var location: Location?
    
    var people = [String]()
    
    var url: URL
    
    var height: Pixel
    var width: Pixel
    
    var megapixels: Double { return Double(height * width) / 1_048_576 }
    
    static func new(dateTaken: Date?, location: Location?, urlString: String) -> Photo {
        let url = URL(fileURLWithPath: urlString)
        
        let new = Photo(dateTaken: dateTaken, location: location, url: url)
        
        return new
    }
    
    private init(dateTaken: Date?, location: Location?, url: URL) {
        self.uniqueID = UniqueIDGenerator.instance.photoID
        self.dateTaken = dateTaken
        self.dateAdded = Date()
        self.location = location
        self.url = url
        
        self.image = ImageFileManager.retrieveImage(at: url)
        
        self.height = 0
        self.width = 0
    }
    
    private init(uniqueID: String, dateTaken: Date?, dateAdded: Date, location: Location?, url: URL) {
        self.uniqueID = uniqueID
        self.dateTaken = dateTaken
        self.dateAdded = dateAdded
        self.location = location
        self.url = url
        
        self.image = ImageFileManager.retrieveImage(at: url)
        
        self.height = 0
        self.width = 0
    }
}
