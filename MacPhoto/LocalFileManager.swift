//
//  LocalFileManager.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class LocalFileManager {
    
    private init() {}
    static let instance = LocalFileManager()
    
    
    //MARK: - Utilities
    private let fileManager = FileManager.default
    
    private func parseIDString(_ dictionary: [String:Bool]) -> String {
        //MARK: People
        var string = String()
        for uniqueID in dictionary.keys {
            string += uniqueID + ";"
        }
        string.remove(at: string.index(before: string.endIndex))
        
        return string
    }
    
    private func parseIDString(_ string: String) -> [String:Bool] {
        var dictionary = [String:Bool]()
        for uniqueID in string.components(separatedBy: ";"){
            dictionary.updateValue(true, forKey: uniqueID)
        }
        return dictionary
    }
    
    //MARK: - Local File Paths
    private var programDirectoryHome = URL(fileURLWithPath: Factbook.picturesPath)
    
    private var programDirectory: URL { return programDirectoryHome.appendingPathComponent("MacPhoto") }
    
    private var imageDirectory: URL { return programDirectory.appendingPathComponent("Images") }
    
    private var infoDirectory: URL { return programDirectory.appendingPathComponent("Info") }
    
    
    //MARK: - CSV Tools
    
    private func writeJSON(to url: URL, withContent dictionary: [String:Any]) {
        
        let data: Data
        
        do {
            data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            try data.write(to: url)
            print("SUCCESS: Saveed to \(url.path)")
        } catch {
            print(error)
            return
        }
        
    }
    private func readJSON(from url: URL) -> [String:Any] {
        let dictionary: [String:Any]?
        
        do {
            let data = try Data(contentsOf: url)
            dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
        } catch {
            print(error)
            return [:]
        }
        
        return dictionary ?? [:]
    }
    
    //MARK: - Directory Tools
    func check(for file: URL) -> Bool {
        var isDir : ObjCBool = ObjCBool(true)
        
        if fileManager.fileExists(atPath: file.relativePath, isDirectory:&isDir) {
            if isDir.boolValue {
                return true
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    //MARK: - Image Management
    
    func save(image: NSImage, withID uniqueID: String) {
        let path = imageDirectory.appendingPathComponent("\(uniqueID).jpg")
        
        if !check(for: path) {
            do {
                try fileManager.createDirectory(at: imageDirectory, withIntermediateDirectories: true, attributes: [:])
            } catch {
                
            }
        }
        
        if let bits = image.representations.first as? NSBitmapImageRep {
            let imageData = bits.representation(using: .JPEG, properties: [:])
            
            do {
                try imageData?.write(to: path)
                print("SUCCESS: Image written to \(path)")
            } catch {
                
            }
        }
        
    }
    
    func load(imageWithID uniqueID: String) -> NSImage? {
        let path = imageDirectory.appendingPathComponent("\(uniqueID).jpg")
        return NSImage(contentsOf: path)
    }
    
    //MARK: - Person Info Management
    
    private var personInfoFile: URL { return infoDirectory.appendingPathComponent("PersonInfo.json") }
    
    func checkForPersonInfoFile() -> Bool {
        return check(for: personInfoFile)
    }
    
    func savePersonInfo() {
        var dictionary = [String:Any]()
        
        for uniqueID in DataStore.instance.people.uniqueIDs {
            guard let person = DataStore.instance.people.with(uniqueID: uniqueID) else { print("FAILURE: Failed to save photo info for unique ID \(uniqueID)"); continue }
            
            JSONManager.save(person: person, to: &dictionary)
        }
        
        writeJSON(to: personInfoFile, withContent: dictionary)
    }
    
    func loadPersonInfo() {
        let dictionary = readJSON(from: personInfoFile)
        
        for (key,value) in dictionary {
            guard let personDictionary = value as? [String:Any] else { print("FAILURE: Could not create dictionary for person with uniqueID \(key)"); continue }
            
            JSONManager.loadPerson(from: personDictionary)
        }
    }
    
    //MARK: - Photo Info Management
    
    private var photoInfoFile: URL { return infoDirectory.appendingPathComponent("PhotoInfo.csv") }
    
    func checkForPhotoInfoFile() -> Bool {
        return check(for: photoInfoFile)
    }
    
}
