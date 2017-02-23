//
//  Location.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Location {
    
    var name: String
    var coordinates: CLLocationCoordinate2D
    
    var photoKeys = [String:Bool]()
    
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
    }
    
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
    
}
