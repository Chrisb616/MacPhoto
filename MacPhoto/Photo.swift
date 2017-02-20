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
    
    //MARK: Location
    var url: URL
    
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
    static func new(dateTaken: Date?, location: Location?, urlString: String) {
        let url = URL(fileURLWithPath: urlString)
        
        let new = Photo(dateTaken: dateTaken, location: location, url: url)
        
        DataStore.instance.photos.append(new)
    }
    
//    static func load(from storedPhoto: StoredPhoto) {
//        guard let uniqueID = storedPhoto.uniqueID else {print("FAILURE: Could not retreive photoID for stored photo"); return }
//        guard let urlString = storedPhoto.url else { print("FAILURE: Could not retrieve url string for photo \(uniqueID)"); return }
//        guard let dateAddedRaw = storedPhoto.dateAdded else { print("FAILURE: Could not retrieve date added for photo \(uniqueID)"); return }
//        let dateAdded = dateAddedRaw as Date
//        
//        let photo = Photo(uniqueID: uniqueID, dateTaken: storedPhoto.dateTaken as? Date, dateAdded: dateAdded, location: nil, url: URL(fileReferenceLiteralResourceName: urlString))
//        
//        DataStore.instance.photos.append(photo)
//    }
    
    //MARK: - Private Initializers
    private init(dateTaken: Date?, location: Location?, url: URL) {
        self.uniqueID = UniqueIDGenerator.instance.photoID
        self.dateTaken = dateTaken
        self.dateAdded = Date()
        self.location = location
        self.url = url
        
        self.image = LocalFileManager.instance.retrieveImage(for: uniqueID)
        
        self.height = 0
        self.width = 0
    }
    
    private init(uniqueID: String, dateTaken: Date?, dateAdded: Date, location: Location?, url: URL) {
        self.uniqueID = uniqueID
        self.dateTaken = dateTaken
        self.dateAdded = dateAdded
        self.location = location
        self.url = url
        
        self.image = LocalFileManager.instance.retrieveImage(for: uniqueID)
        
        self.height = 0
        self.width = 0
    }
}
