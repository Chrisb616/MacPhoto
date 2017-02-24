//
//  UserDefaultsManager.swift
//  PhotoOrganizer
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import CoreData

class UserDefaultsManager {
    
    private init() {}
    static let instance = UserDefaultsManager()
    
    //MARK: - User Defaults
    private let defaults = UserDefaults.standard
    
    //MARK: Keys
    private let photoIDKey = "photoID"
    private let personIDKey = "personID"
    private let locationIDKey = "locationID"
    
    //MARK: - ID Management
    
    //MARK: Save IDs
    func savePhotoID(_ ID: String) {
        defaults.set(ID, forKey: photoIDKey)
    }
    
    func savePersonID(_ ID: String) {
        defaults.set(ID, forKey: personIDKey)
    }
    
    func saveLocationID(_ ID: String) {
        defaults.set(ID, forKey: locationIDKey)
    }

    //MARK: Load IDs
    func loadPhotoID() -> String? {
        
        guard let photoIDRaw = defaults.object(forKey: photoIDKey) else { return nil }
        return photoIDRaw as? String
    }
    
    func loadPersonID() -> String? {
        
        guard let personIDRaw = defaults.object(forKey: personIDKey) else { return nil }
        return personIDRaw as? String
        
    }
    
    func loadLocationID() -> String? {
        guard let locationIDRaw = defaults.object(forKey: locationIDKey) else { return nil }
        return locationIDRaw as? String
    }
    
    //MARK: - Remove UserDefault Data
    func removeSaveData() {
        removePhotoIDSaveData()
    }
    
    func removeAllIDData() {
        removePhotoIDSaveData()
    }
    
    func removePhotoIDSaveData() {
        defaults.removeObject(forKey: photoIDKey)
    }
    
    func removePersonIDSaveData() {
        defaults.removeObject(forKey: personIDKey)
    }
    
    func removeLocationIDSaveData() {
        defaults.removeObject(forKey: locationIDKey)
    }

}
