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
    
    private weak var safeArea: Area?
    var area: Area? { return safeArea }
    
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
    
    //MARK: - Object Creation
    static func new(name: String, coordinates: CLLocationCoordinate2D) {
        let new = Spot(name: name, coordinates: coordinates)
        
        DataStore.instance.spots.add(new)
    }
    
    static func load(uniqueID: String, name: String, shortDescription: String, longDescription: String, coordinates: CLLocationCoordinate2D, generalAreaID: String) {
        guard let generalArea = DataStore.instance.areas.with(uniqueID: generalAreaID) else { print() return }
        
        let new = Spot(uniqueID: uniqueID, name: name, shortDescription: shortDescription, longDescription: longDescription, coordinates: coordinates, generalArea: generalArea)
        
        DataStore.instance.spots.add(new)
    }
    
    //MARK: - Private Initializers
    private init(name: String, coordinates: CLLocationCoordinate2D) {
        self.name = name
        self.coordinates = coordinates
        self.uniqueID = UniqueIDGenerator.instance.personID
        self.name = ""
        self.shortDescription = ""
        self.longDescription = ""
    }
    
    private init(uniqueID: String, name: String, shortDescription: String, longDescription: String, coordinates: CLLocationCoordinate2D, generalArea: Area) {
        self.uniqueID = uniqueID
        self.name = name
        self.shortDescription = shortDescription
        self.longDescription = longDescription
        self.coordinates = coordinates
        self.safeArea = generalArea
    }
    
    func set(area: Area) {
        safeArea = area
        area.spots.updateValue(true, forKey: self.uniqueID)
    }
}
