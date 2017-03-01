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
    
    //MARK: Object Creation
    static func new(name: String, generalCoordinates: CLLocationCoordinate2D) -> Region {
        let new = Region(name: name, generalCoordinates: generalCoordinates)
        
        new.generalArea.set(region: new)
        
        return new
    }
    
    //MARK: Private initializers
    init(name: String, generalCoordinates: CLLocationCoordinate2D) {
        self.uniqueID = ""
        self.name = name
        self.generalArea = Area.new(name: name, generalCoordinates: generalCoordinates)
        self.areas = [self.generalArea.uniqueID:true]
    }
    
}
