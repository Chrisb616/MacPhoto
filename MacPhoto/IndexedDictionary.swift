//
//  IndexedDictionary.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/25/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

struct IndexedDictionary<T: HasUniqueID> {
    private var keys = [String:Int]()
    private var values = [T]()
    
    var all: [T] { return values }
    
    var uniqueIDs: [String] {
        var uniqueIDs = [String]()
        
        for key in keys.keys {
            uniqueIDs.append(key)
        }
        
        return uniqueIDs
    }
    
    var count: Int { return values.count }
    
    //MARK: - Change Values
    mutating func add(_ item: T) {
        let newIndex = values.count
        values.append(item)
        keys[item.uniqueID] = newIndex
    }
    mutating func remove(_ item: T) {
        guard let index = keys[item.uniqueID] else { return }
        values.remove(at: index)
        
        keys.removeAll()
        
        for (index, item) in values.enumerated() {
            keys.updateValue(index, forKey: item.uniqueID)
        }
    }
    
    //MARK: - Find Values
    func at(index: Int) -> T {
        return values[index]
    }
    func with(uniqueID: String) -> T? {
        guard let index = keys[uniqueID] else { return nil }
        return values[index]
    }
    
    //MARK: - Clear Values
    mutating func clear() {
        keys.removeAll()
        values.removeAll()
    }
    
    var random: T {
        let rand = Int(arc4random_uniform(UInt32(count)))
        
        return at(index: rand)
    }
}
