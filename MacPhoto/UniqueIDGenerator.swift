//
//  UniqueIDGenerator.swift
//  Photo
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

class UniqueIDGenerator {
    
    private init() {}
    static let instance = UniqueIDGenerator()
    
    //MARK: - New IDs
    var photoID: String {
        let resultID = loadPhotoID() ?? "PH000000"
        
        let newID = advanced(resultID)
        savePhotoID(newID)
        
        return newID
    }
    
    var personID: String {
        let resultID = loadPersonID() ?? "PN000000"
        
        let newID = advanced(resultID)
        savePersonID(newID)
        
        return newID
    }
    
    var spotID: String {
        let resultID = loadSpotID() ?? "SP000000"
        
        let newID = advanced(resultID)
        saveSpotID(newID)
        
        return newID
    }
    
    var areaID: String {
        let resultID = loadAreaID() ?? "AR000000"
        
        let newID = advanced(resultID)
        saveAreaID(newID)
        
        return newID
    }
    
    var regionID: String {
        let resultID = loadRegionID() ?? "RE000000"
        
        let newID = advanced(resultID)
        saveRegionID(newID)
        
        return newID
    }
    
    //MARK: - Advance Functions
    private func advanced(_ ID: String) -> String {
        var characters = ID.characters
        
        if characters.count == 0 { return "0" }
        
        let last = characters.removeLast() as Character
        
        
        if last == "Z" {
            var truncatedID: String = ""
            
            for character in characters {
                truncatedID.append(character)
            }
            
            characters = advanced(truncatedID).characters
            
            characters.append("0")
        } else {
            characters.append(advanced(character: last))
        }
        
        var result: String = ""
        
        for character in characters {
            result.append(character)
        }
        
        return result
    }
    
    private func advanced(character: Character) -> Character {
        switch character {
        case "0": return "1"
        case "1": return "2"
        case "2": return "3"
        case "3": return "4"
        case "4": return "5"
        case "5": return "6"
        case "6": return "7"
        case "7": return "8"
        case "8": return "9"
        case "9": return "A"
        case "A": return "B"
        case "B": return "C"
        case "C": return "D"
        case "D": return "E"
        case "E": return "F"
        case "F": return "G"
        case "G": return "H"
        case "H": return "I"
        case "I": return "J"
        case "J": return "K"
        case "K": return "L"
        case "L": return "M"
        case "M": return "N"
        case "N": return "O"
        case "O": return "P"
        case "P": return "Q"
        case "Q": return "R"
        case "R": return "S"
        case "S": return "T"
        case "T": return "U"
        case "U": return "V"
        case "V": return "W"
        case "W": return "X"
        case "X": return "Y"
        case "Y": return "Z"
        default: return "0"
        }
    }
    
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
