//
//  PersonData.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/21/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

struct PersonData {
    
    private weak var weakPerson: Person?
    private var person: Person { return weakPerson! }
    
    init(_ person: Person){
        self.weakPerson = person
    }
    
    init() {}
    
    //MARK: - Stat Variables And Functions
    var totalPhotos: Int = 0
    mutating func calculateTotalPhotos() {
        totalPhotos = person.photos.count
    }
    
    
    mutating func reloadStats() {
        calculateTotalPhotos()
    }
    
    
}
