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
    
    var locationID: String {
        let resultID = loadLocationID() ?? "SP000000"
        
        let newID = advanced(resultID)
        saveLocationID(newID)
        
        return newID
    }
    
    //MARK: - Advance Functions
    private func advanced(_ ID: String) -> String {
        var characters = ID
        
        if characters.count == 0 { return "0" }
        
        let last = characters.removeLast() as Character
        
        
        if last == "Z" {
            var truncatedID: String = ""
            
            for character in characters {
                truncatedID.append(character)
            }
            
            characters = advanced(truncatedID)
            
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
    private let locationIDKey = "locationID"
    
    //MARK: - ID Management
    
    //MARK: Save IDs
    private func savePhotoID(_ ID: String) {
        defaults.set(ID, forKey: photoIDKey)
    }
    
    private func savePersonID(_ ID: String) {
        defaults.set(ID, forKey: personIDKey)
    }
    
    private func saveLocationID(_ ID: String) {
        defaults.set(ID, forKey: locationIDKey)
    }
    
    
    //MARK: Load IDs
    private func loadPhotoID() -> String? {
        guard let photoIDRaw = defaults.object(forKey: photoIDKey) else { return nil }
        return photoIDRaw as? String
    }
    
    private func loadPersonID() -> String? {
        guard let personIDRaw = defaults.object(forKey: personIDKey) else { return nil }
        return personIDRaw as? String
    }
    
    private func loadLocationID() -> String? {
        guard let locationIDRaw = defaults.object(forKey: locationIDKey) else { return nil }
        return locationIDRaw as? String
    }
    
    //MARK: - Remove UserDefault Data
    func removeSaveData() {
        removeAllIDData()
    }
    
    func removeAllIDData() {
        removePhotoIDSaveData()
        removePersonIDSaveData()
        removeLocationIDSaveData()
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
