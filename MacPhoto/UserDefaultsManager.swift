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
    
    
    //MARK: - ID Management
    func savePhotoID(_ ID: String) {
        print("Saving \(ID)")
        defaults.set(ID, forKey: photoIDKey)
    }
    
    func savePersonID(_ ID: String) {
        defaults.set(ID, forKey: personIDKey)
    }
    
    func loadIDs() {
        print("Loading!")
        let photoID = loadPhotoID()
        let personID = loadPersonID()
        
        UniqueIDGenerator.instance.loadIDs(photoID: photoID, personID: personID)
    }
    
    private func loadPhotoID() -> String? {
        
        guard let photoIDRaw = defaults.object(forKey: photoIDKey) else { return nil }
        guard let photoID = photoIDRaw as? String else { return nil }
        
        print("photoID is \(photoID)")
        
        return photoID
    }
    
    private func loadPersonID() -> String? {
        
        guard let personIDRaw = defaults.object(forKey: personIDKey) else { return nil }
        guard let personID = personIDRaw as? String else { return nil }
        
        return personID
        
    }
    
    //MARK: - Remove UserDefault Data
    func RemoveSaveData(passcode: String) {
        print("Destroy all data initialzed. Passcode: \(passcode)")
        if passcode.contains("DESTROY") {
            removePhotoIDSaveData(passcode: passcode)
        }
    }
    
    func removePhotoIDSaveData(passcode: String) {
        if passcode.contains("PHOTOS") {
            defaults.removeObject(forKey: photoIDKey)
            print("Destroyed Photo Data")
        }
    }

}
