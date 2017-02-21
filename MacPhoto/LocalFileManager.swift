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
    
    
    //MARK: - Utility Properties
    private let fileManager = FileManager.default
    
    //MARK: - Local File Paths
    private var programDirectoryHome = URL(fileURLWithPath: Factbook.picturesPath)
    
    var programDirectory: URL { return programDirectoryHome.appendingPathComponent("MacPhoto") }
    
    private var imageDirectory: URL { return programDirectory.appendingPathComponent("Images") }
    
    //MARK: - Directory Management
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
        let url = imageDirectory.appendingPathComponent("\(uniqueID).jpg")
        
        if !check(for: url) {
            do {
                try fileManager.createDirectory(at: imageDirectory, withIntermediateDirectories: true, attributes: [:])
            } catch {
                
            }
        }
        
        if let bits = image.representations.first as? NSBitmapImageRep {
            print(url)
            let imageData = bits.representation(using: .JPEG, properties: [:])
            
            do {
                try imageData?.write(to: url)
            } catch {
                
            }
        }
        
    }
    
    func retrieveImage(for uniqueID: String) -> NSImage {
        
        return NSImage()
    }
    
}
