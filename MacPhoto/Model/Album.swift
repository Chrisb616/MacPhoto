//
//  Album.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/31/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class Album {
    
    var name: String
    
    private var safePhotos: IndexedDictionary<Photo> = IndexedDictionary<Photo>()
    var photos: IndexedDictionary<Photo> { return safePhotos }
    
    init(name: String) {
        self.name = name
    }
    
    func add(_ photo: Photo) {
        safePhotos.add(photo)
    }
    
    func remove(_ photo: Photo) {
        safePhotos.remove(photo)
    }
    
}
