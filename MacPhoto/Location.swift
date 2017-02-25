//
//  Location.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Location {
    
    //MARK: - Properties
    
    var uniqueID: String
    
    var name: String
    
    var coordinates: CLLocationCoordinate2D
    
    var photoKeys = [String:Bool]()
    
    //MARK: - Access Through ID
    static func with(uniqueID: String) -> Location? {
        if uniqueID == "" { return nil }
        
        if let location = DataStore.instance.locations[uniqueID] {
            return location
        } else {
            print("WARNING: Location not found for unique ID: \(uniqueID)")
            return nil
        }
    }
    
    //MARK: - Object relationships
    
    func associatePhoto(withUniqueID uniqueID: String) {
        
        guard let photo = Photo.with(uniqueID: uniqueID) else { return }
        
        if let oldLocation = photo.location {
            oldLocation.disassociatePhoto(withUniqueID: uniqueID)
        }
        
        photo.location = self
        self.photoKeys.updateValue(true, forKey: uniqueID)
        
    }
    func disassociatePhoto(withUniqueID uniqueID: String) {
        
        guard let photo = Photo.with(uniqueID: uniqueID) else { return }
        
        photo.location = nil
        self.photoKeys.removeValue(forKey: uniqueID)
        
    }
    
    //MARK: - Initializers
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
        self.uniqueID = UniqueIDGenerator.instance.personID
    }
}
