//
//  Region.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/28/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

class Region: HasUniqueID {
    
    //MARK: - Stored Properties
    
    //MARK: UniqueID
    var uniqueID: String
    
    //MARK: Name and Description
    var name: String
    
    //MARK: Areas
    var generalArea: Area
    var areas: [String:Bool]
    
    //MARK: Regions
    weak var superRegion: Region?
    var subRegions = [String:Bool]()
    
    //MARK: Object Creation
    static func new(name: String, generalCoordinates: CLLocationCoordinate2D) {
        let new = Region(name: name, generalCoordinates: generalCoordinates)
        
        new.generalArea.set(region: new)
        
        DataStore.instance.regions.add(new)
    }
    
    static func load(uniqueID: String, name: String, generalAreaUniqueID: String) {
        guard let area = DataStore.instance.areas.with(uniqueID: generalAreaUniqueID) else { return }
        
        let new = Region(uniqueID: uniqueID, name: name, generalArea: area)
        
        area.set(region: new)
        
        DataStore.instance.regions.add(new)
    }
    
    //MARK: Private initializers
    private init(name: String, generalCoordinates: CLLocationCoordinate2D) {
        self.uniqueID = UniqueIDGenerator.instance.regionID
        self.name = name
        self.generalArea = Area.new(name: name, generalCoordinates: generalCoordinates)
        self.areas = [self.generalArea.uniqueID:true]
    }
    
    private init(uniqueID: String, name: String, generalArea: Area) {
        self.uniqueID = uniqueID
        self.name = name
        self.generalArea = generalArea
        self.areas = [generalArea.uniqueID:true]
    }
}
