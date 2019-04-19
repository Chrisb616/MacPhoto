//
//  Area.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/28/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Area: Location {
    
    //MARK: - Stored Properties
    
    //MARK: Unique ID
    var uniqueID: String
    
    //MARK: Name and Description
    var name: String
    
    //MARK: Spots
    var spots = [String:Bool]()
    
    //MARK: Areas
    var subAreas = [String:Bool]()
    var superAreas = [String:Bool]()
    
    //MARK: Photos
    var photos = [String:Bool]()
    
    //MARK: Location
    var location: CLLocationCoordinate2D
    var locationCount = 0
    var needsLocationRecalculation = true
    private func recalculateLocation() {
        var coordinates = [CLLocationCoordinate2D]()
        
        for spotID in spots.keys {
            guard let spot = DataStore.instance.spots.with(uniqueID: spotID) else {
                print("FAILURE: Could not find spot \(spotID) for area \(uniqueID)")
                continue
            }
        
            coordinates.append(spot.location)
        }
        for areaID in subAreas.keys {
            guard let area = DataStore.instance.areas.with(uniqueID: areaID) else {
                print("FAILURE: Could not find sub area \(areaID) for area \(uniqueID)")
                continue
            }
            
            if area.needsLocationRecalculation {
                area.recalculateLocation()
            }
            
            for _ in 0..<area.locationCount {
                coordinates.append(area.location)
            }
        }
        
        locationCount = coordinates.count
        
        if locationCount == 0 {
            return
        }
        
        var latitudeTotal: CLLocationDegrees = 0.0
        var longitudeTotal: CLLocationDegrees = 0.0
        
        for coordinate in coordinates {
            latitudeTotal += coordinate.latitude
            longitudeTotal += coordinate.longitude
        }
        
        let latitudeAvg = latitudeTotal/Double(locationCount)
        let longitudeAvg = longitudeTotal/Double(locationCount)
        
        self.location = CLLocationCoordinate2D(latitude: latitudeAvg, longitude: longitudeAvg)
    }

    //MARK: - Object Creation
    static func new(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> Area {
        let generalLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let new = Area(name: name, generalLocation: generalLocation)
        
        DataStore.instance.areas.add(new)
        
        return new
    }
    
    static func load(uniqueID: String, name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let new = Area(uniqueID: uniqueID, name: name, location: location)
        
        DataStore.instance.areas.add(new)
    }
    
    //MARK: - Private initializers
    private init(name: String, generalLocation: CLLocationCoordinate2D){
        self.uniqueID = UniqueIDGenerator.instance.locationID
        self.name = name
        self.location = generalLocation
        self.locationCount = 0
    }
    private init(uniqueID: String, name: String, location: CLLocationCoordinate2D) {
        self.uniqueID = uniqueID
        self.name = name
        self.location = location
    }
    
}
