//
//  Location.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/7/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreLocation

protocol Location: class, HasUniqueID {
    
    var location: CLLocationCoordinate2D { get set }
    var photos: [String:Bool] { get set }
    
}
extension Location {
    
    static func withID(_ uniqueID: String) -> Location? {
        if let spot = DataStore.instance.spots.with(uniqueID: uniqueID) { return spot }
        if let area = DataStore.instance.areas.with(uniqueID: uniqueID) { return area }
        return nil
    }
    
    var globeQuarter: Int {
        switch location.longitude {
        case (-180.0)..<(-90.0): return 1
        case (-90.0)..<0.0: return 2
        case 0..<90.0: return 3
        default: return 4
        }
    }
}
