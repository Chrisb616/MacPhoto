//
//  Spot.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Spot: Location {
    
    //MARK: - Properties
    
    //MARK: UniqueID
    var uniqueID: String
    
    //MARK: Location
    var location: CLLocationCoordinate2D
    
    private weak var safeArea: Area?
    var area: Area? { return safeArea }
    
    //MARK: Story Info
    var name: String
    var shortDescription: String?
    var longDescription: String?
    
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
    
    //MARK: - Object Creation
    static func new(name: String, coordinates: CLLocationCoordinate2D) -> Spot {
        let new = Spot(name: name, location: coordinates)
        
        DataStore.instance.spots.add(new)
        
        return new
    }
    
    static func load(uniqueID: String, name: String, shortDescription: String, longDescription: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, area: String) {
        guard let generalArea = DataStore.instance.areas.with(uniqueID: area) else { print("FAILURE: Could not find area with unique ID: \(area)"); return }
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let new = Spot(uniqueID: uniqueID, name: name, shortDescription: shortDescription, longDescription: longDescription, location: location, generalArea: generalArea)
        
        DataStore.instance.spots.add(new)
    }
    
    //MARK: - Private Initializers
    private init(name: String, location: CLLocationCoordinate2D) {
        self.uniqueID = UniqueIDGenerator.instance.locationID
        self.name = name
        self.location = location
    }
    
    private init(uniqueID: String, name: String, shortDescription: String, longDescription: String, location: CLLocationCoordinate2D, generalArea: Area) {
        self.uniqueID = uniqueID
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.location = location
        self.safeArea = generalArea
    }
    
    func set(area: Area) {
        safeArea = area
        area.spots.updateValue(true, forKey: self.uniqueID)
    }
}
