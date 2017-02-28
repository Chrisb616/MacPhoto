//
//  Location.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Location: HasUniqueID {
    
    //MARK: - Properties
    
    var uniqueID: String
    
    var name: String
    
    var coordinates: CLLocationCoordinate2D
    
    var photos = [String:Bool]()
    
    //MARK: - Access Through ID
    static func with(uniqueID: String) -> Location? {
        if uniqueID == "" { return nil }
        
        if let location = DataStore.instance.locations.with(uniqueID: uniqueID) {
            return location
        } else {
            print("WARNING: Location not found for unique ID: \(uniqueID)")
            return nil
        }
    }
    
    //MARK: - Initializers
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
        self.uniqueID = UniqueIDGenerator.instance.personID
    }
}
