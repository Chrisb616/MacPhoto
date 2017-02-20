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
    
    private let dataManager = DataManager.instance
    
    var photoID: String {
        let resultID = photoIDStorage
        
        let newID = advanced(resultID)
        photoIDStorage = newID
        
        dataManager.savePhotoID(newID)
        
        return resultID
    }
    
    func loadIDs(photoID: String?) {
        photoIDStorage = photoID ?? "000000"
    }
    
    private var photoIDStorage = "000000"
    
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
}
