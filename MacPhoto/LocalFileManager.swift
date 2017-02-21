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
    
    
    //MARK: - Local File Paths
    private var programDirectoryHome = URL(fileURLWithPath: Factbook.picturesPath)
    
    private var programDirectory: URL { return programDirectoryHome.appendingPathComponent("MacPhoto") }
    
    private var imageDirectory: URL { return programDirectory.appendingPathComponent("Images") }
    
    //MARK: - Retrieve Image
    func save(image: NSImage, withID uniqueID: String) {
        let url = imageDirectory.appendingPathComponent("\(uniqueID).jpg")
        
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
