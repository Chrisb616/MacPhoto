//
//  ConsistencyManager.swift
//  MacPhoto
//
//  Created by Admin on 4/2/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

struct ConsistencyManager{
    
    private init() {}
    
    private let store = DataStore.instance
    
    static func check() {
        
        let instance = ConsistencyManager()
        
        instance.photoPersonTags()
        
    }
    
    private func photoPersonTags() {
        
        for photo in store.photos.all {
            
            for uniqueID in photo.people.keys {
                
                guard let person = store.people.with(uniqueID: uniqueID) else {
                    continue
                }
                
                if person.photos[uniqueID] == nil {
                    person.photos.updateValue(true, forKey: photo.uniqueID)
                }
                
            }
            
        }
        
    }
    
}
