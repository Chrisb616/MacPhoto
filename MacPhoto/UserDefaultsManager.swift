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
    private let spotIDKey = "spotID"
    private let areaIDKey = "areaID"
    private let regionIDKey = "regionID"
    
    //MARK: - ID Management
    
    //MARK: Save IDs
    func savePhotoID(_ ID: String) {
        defaults.set(ID, forKey: photoIDKey)
    }
    
    func savePersonID(_ ID: String) {
        defaults.set(ID, forKey: personIDKey)
    }
    
    func saveSpotID(_ ID: String) {
        defaults.set(ID, forKey: spotIDKey)
    }
    
    func saveAreaID(_ ID: String) {
        defaults.set(ID, forKey: areaIDKey)
    }
    
    func saveRegionID(_ ID: String) {
        defaults.set(ID, forKey: regionIDKey)
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
    
    func loadSpotID() -> String? {
        guard let spotIDRaw = defaults.object(forKey: spotIDKey) else { return nil }
        return spotIDRaw as? String
    }
    
    func loadAreaID() -> String? {
        guard let areaIDRaw = defaults.object(forKey: areaIDKey) else { return nil }
        return areaIDRaw as? String
    }
    
    func loadRegionID() -> String? {
        guard let regionIDRaw = defaults.object(forKey: regionIDKey) else { return nil }
        return regionIDRaw as? String
    }
    
    //MARK: - Remove UserDefault Data
    func removeSaveData() {
        removeAllIDData()
    }
    
    func removeAllIDData() {
        removePhotoIDSaveData()
        removePersonIDSaveData()
        removeSpotIDSaveData()
        removeAreaIDSaveData()
        removeRegionIDSaveData()
    }
    
    func removePhotoIDSaveData() {
        defaults.removeObject(forKey: photoIDKey)
    }
    
    func removePersonIDSaveData() {
        defaults.removeObject(forKey: personIDKey)
    }
    
    func removeSpotIDSaveData() {
        defaults.removeObject(forKey: spotIDKey)
    }
    
    func removeAreaIDSaveData() {
        defaults.removeObject(forKey: areaIDKey)
    }
    
    func removeRegionIDSaveData() {
        defaults.removeObject(forKey: regionIDKey)
    }

}
