//
//  DataManager.swift
//  PhotoOrganizer
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

struct DataManager {
    
    private static let defaults = UserDefaults.standard
    
    private static var photoIDKey = "photoID"
    
    static func savePhotoID(_ ID: String) {
        print("Saving \(ID)")
        defaults.set(ID, forKey: photoIDKey)
    }
    
    static func loadIDs() {
        print("Loading!")
        let photoID = loadPhotoID()
        
        UniqueIDGenerator.instance.loadIDs(photoID: photoID)
    }
    
    private static func loadPhotoID() -> String? {
        
        guard let photoIDRaw = defaults.object(forKey: photoIDKey) else { return nil }
        guard let photoID = photoIDRaw as? String else { return nil }
        
        print("photoID is \(photoID)")
        
        return photoID
    }
    
    static func destroyAllSaveData(passcode: String) {
        print("Destroy all data initialzed. Passcode: \(passcode)")
        if passcode.contains("DESTROY") {
            destroyPhotoIDSaveData(passcode: passcode)
        }
    }
    
    static func destroyPhotoIDSaveData(passcode: String) {
        if passcode.contains("PHOTOS") {
            defaults.removeObject(forKey: photoIDKey)
            print("Destroyed Photo Data")
        }
    }
    
}
