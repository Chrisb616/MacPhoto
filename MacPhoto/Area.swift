//
//  Area.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/28/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class Area: HasUniqueID {
    
    //MARK: - Properties
    
    //MARK: Unique ID
    var uniqueID: String
    
    //MARK: Spots
    var spots: [String:Bool]
    var generalSpot: Spot
    
    init(){
        uniqueID = ""
        generalSpot = Spot(name: "", coordinates: <#T##CLLocationCoordinate2D#>)
    }
}
