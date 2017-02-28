//
//  Spot.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Spot: HasUniqueID {
    
    //MARK: - Properties
    
    //MARK: UniqueID
    var uniqueID: String
    
    //MARK: Location
    var coordinates: CLLocationCoordinate2D
    
    //MARK: Story Info
    var name: String
    var shortDescription: String
    var longDescription: String
    
    //MARK: Photos
    var photos = [String:Bool]()
    
    //MARK: - Access Through ID
    static func with(uniqueID: String) -> Spot? {
        if uniqueID == "" { return nil }
        
        if let spot = DataStore.instance.spots.with(uniqueID: uniqueID) {
            return spot
        } else {
            print("WARNING: Spot not found for unique ID: \(uniqueID)")
            return nil
        }
    }
    
    //MARK: - Initializers
    init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
        self.uniqueID = UniqueIDGenerator.instance.personID
        self.name = ""
        self.shortDescription = ""
        self.longDescription = ""
    }
}
