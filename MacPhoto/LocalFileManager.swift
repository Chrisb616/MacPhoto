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
    
    private func parseDate(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY_MM_dd_HH_mm_ss"
        return dateFormatter.date(from: string)
    }
    
    //MARK: - Local File Paths
    private var programDirectoryHome = URL(fileURLWithPath: Factbook.picturesPath)
    
    private var programDirectory: URL { return programDirectoryHome.appendingPathComponent("MacPhoto") }
    
    private var imageDirectory: URL { return programDirectory.appendingPathComponent("Images") }
    
    private var infoDirectory: URL { return programDirectory.appendingPathComponent("Info") }
    
    
    //MARK: - CSV Tools
    func writeCSV(to path: URL, withName name: String, withContent string: String){
        
        do{
            try string.write(to: path.appendingPathComponent("\(name).csv"), atomically: true, encoding: String.Encoding.utf8)
        } catch{
            print("FAILURE: Could not write \(name).csv to \(path)")
        }
    }
    func readCSV(from path: URL, withName name: String = "") -> String? {
        do {
            let contents = try String(contentsOf: path.appendingPathComponent("\(name).csv"), encoding: String.Encoding.utf8)
            return contents
        } catch {
            print("FAILURE: Could not read from file path: \(path)")
            return nil
        }
    }
    
    //MARK: - Directory Tools
    func check(for file: URL) -> Bool {
        var isDir : ObjCBool = ObjCBool(true)
        
        if fileManager.fileExists(atPath: file.relativePath, isDirectory:&isDir) {
            if isDir.boolValue {
                print(1)
                return true
            } else {
                print(2)
                return true
            }
        } else {
            print(3)
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
            print(path)
            let imageData = bits.representation(using: .JPEG, properties: [:])
            
            do {
                try imageData?.write(to: path)
            } catch {
                
            }
        }
        
    }
    
    func load(imageWithID uniqueID: String) -> NSImage? {
        let path = imageDirectory.appendingPathComponent("\(uniqueID).jpg")
        return NSImage(contentsOf: path)
    }
    
    //MARK: PhotoInfoManagement
    
    private var photoInfoFile: URL { return infoDirectory.appendingPathComponent("PhotoInfo.csv") }
    
    func checkForPhotoInfoFile() -> Bool {
        return check(for: photoInfoFile)
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
