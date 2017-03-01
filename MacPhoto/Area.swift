//
//  Area.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/28/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Area: HasUniqueID {
    
    //MARK: - Stored Properties
    
    //MARK: Unique ID
    var uniqueID: String
    
    //MARK: Name and Description
    var name: String
    
    //MARK: Spots
    var spots: [String:Bool]
    var generalSpot: Spot
    
    //MARK: Region
    var region: Region? { return safeRegion }
    private weak var safeRegion: Region?
    
    //MARK: - Object Creation
    static func new(name: String, generalCoordinates: CLLocationCoordinate2D) -> Area {
        let new = Area(name: name, generalCoordinates: generalCoordinates)
        
        DataStore.instance.areas.add(new)
        
        return new
    }
    
    //MARK: - Private initializers
    private init(name: String, generalCoordinates: CLLocationCoordinate2D){
        self.uniqueID = ""
        self.name = name
        self.generalSpot = Spot.new(name: "\(name) (Area)", coordinates: generalCoordinates)
        self.spots = [generalSpot.uniqueID:true]
    }
    
    func set(region: Region) {
        safeRegion = region
    }
}
