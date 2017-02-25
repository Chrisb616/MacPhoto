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
    
    private let dateFormat = "YYYY_MM_dd_HH_mm_ss"
    
    private func parseDate(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: string)
    }
    
    private func parseDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    func removeCommas(from string: String) -> String {
        print(string)
        
        var result = String()
        
        let components = string.components(separatedBy: ",")
        
        if components.count > 1 {
            for (index, component) in components.enumerated() {
                result += component
                
                if index != components.count - 1 {
                    result += "&COMMA"
                }
            }
        }
        
        return result
    }
    
    func replaceCommas(in string: String) -> String {
        var result = String()
        
        let components = string.components(separatedBy: "&COMMA")
        
        if components.count > 1 {
            for (index, component) in components.enumerated() {
                result += component
                
                if index != components.count - 1 {
                    result += ","
                }
            }
        }
        
        return result
    }
    
    //MARK: - Local File Paths
    private var programDirectoryHome = URL(fileURLWithPath: Factbook.picturesPath)
    
    private var programDirectory: URL { return programDirectoryHome.appendingPathComponent("MacPhoto") }
    
    private var imageDirectory: URL { return programDirectory.appendingPathComponent("Images") }
    
    private var infoDirectory: URL { return programDirectory.appendingPathComponent("Info") }
    
    
    //MARK: - CSV Tools
    func writeCSV(to path: URL, withContent string: String){
        
        do{
            try string.write(to: path, atomically: true, encoding: String.Encoding.utf8)
        } catch{
            print("FAILURE: Could not write csv to \(path) \(error)")
        }
    }
    func readCSV(from path: URL) -> String? {
        
        do {
            let contents = try String(contentsOf: path, encoding: String.Encoding.utf8)
            return contents
        } catch {
            print("FAILURE: Could not read from file path: \(path) \(error)")
            return nil
        }
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
    
    //MARK: - Photo Info Management
    
    private var photoInfoFile: URL { return infoDirectory.appendingPathComponent("PhotoInfo.csv") }
    
    func checkForPhotoInfoFile() -> Bool {
        return check(for: photoInfoFile)
    }
    
    func savePhotoInfo() {
        var csvData = CSVContent()
        
        for uniqueID in DataStore.instance.photos.uniqueIDs {
            guard let photo = DataStore.instance.photos.with(uniqueID: uniqueID) else { print("FAILURE: Failed to save photos");return }
            
            var row = [String]()
            
            let dateTakenString: String
            let locationID: String
            
            if let dateTaken = photo.dateTaken {
                dateTakenString = parseDate(dateTaken)
            } else {
                dateTakenString = ""
            }
            
            if let location = photo.location {
                locationID = location.uniqueID
            } else {
                locationID = ""
            }
            
            row.append(uniqueID)
            row.append(removeCommas(from: photo.title ?? ""))
            row.append(removeCommas(from: photo.shortDescription ?? ""))
            row.append(removeCommas(from: photo.longDescription ?? ""))
            row.append(dateTakenString)
            row.append(locationID)
            row.append(parseDate(photo.dateAdded))
            
            csvData.add(row: row)
        }
        
        let string = csvData.string
        
        writeCSV(to: photoInfoFile, withContent: string)
    }
    
    func loadPhotoInfo() {
        if !checkForPhotoInfoFile() { return }
        
        guard let contentString = readCSV(from: photoInfoFile) else { print("FAILURE: Could not read content of PhotoInfo.csv");return }
        
        let content = CSVContent(contentString)
        
        for i in 0..<content.numOfRows {
            let row = content.at(row: i)
            
            let uniqueID = row[0]
            let title = row[1].isEmpty ? nil : row[1]
            let shortDescription = row[2].isEmpty ? nil : row[2]
            let longDescription = row[3].isEmpty ? nil : row[3]
            let dateTakenString = row[4].isEmpty ? nil : row[4]
            let dateTaken = parseDate(dateTakenString ?? "")
            let locationID = row[5].isEmpty ? nil : row[5]
            let location = Location.with(uniqueID: locationID ?? "")
            let dateAddedString = row[5].isEmpty ? nil : row[5]
            let dateAdded = parseDate(dateAddedString ?? "") ?? Date()
            
            Photo.load(uniqueID: uniqueID, title: title, shortDescription: shortDescription, longDescription: longDescription, dateTaken: dateTaken, location: location, dateAdded: dateAdded)
            
        }
    }
}
