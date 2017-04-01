//
//  AddPhotosViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/31/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class AddPhotosViewController: NSViewController {
    
    private let operationQueue = OperationQueue()

    @IBAction func addSinglePhotoButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel()
        
        dialog.title = "Select a photo"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canChooseFiles = true
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = Factbook.allowedImageFileTypes
        
        if dialog.runModal() == NSModalResponseOK {
            
            operationQueue.addOperation{
                
                guard let url = dialog.url else { return }
                
                guard let image = NSImage(contentsOf: url) else { return }
                
                let title = url.lastPathComponent.components(separatedBy: ".")[0]
                
                Photo.new(image: image, title: title, shortDescription: nil, longDescription: nil, dateTaken: nil, location: nil)
                
                self.finishImport()
            }
        }
        
    }
    
    @IBAction func addPhotoGroupButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel()
        
        dialog.title = "Select a group of photos"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canChooseFiles = true
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = true
        dialog.allowedFileTypes = Factbook.allowedImageFileTypes
        
        if dialog.runModal() == NSModalResponseOK {
            
            operationQueue.addOperation {
                for url in dialog.urls {
                    
                    guard let image = NSImage(contentsOf: url) else { return }
                    
                    let title = url.lastPathComponent.components(separatedBy: ".")[0]
                    
                    Photo.new(image: image, title: title, shortDescription: nil, longDescription: nil, dateTaken: nil, location: nil)
                    
                }
                
                self.finishImport()
            }
            
        }
    }
    
    @IBAction func addDirectoryButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel()
        
        dialog.title = "Select a directory of photos"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        
        if dialog.runModal() == NSModalResponseOK {
            
            operationQueue.addOperation {
                
                guard let url = dialog.url else { return }
                
                do {
                    let contents = try FileManager.default.contentsOfDirectory(atPath: url.path)
                    
                    let filtered = contents.filter({ (path) -> Bool in
                        for fileType in Factbook.allowedImageFileTypes {
                            if path.hasSuffix(fileType) {
                                return true
                            }
                        }
                        
                        return false
                    })
                    
                    for item in filtered {
                        let itemURL = URL(fileURLWithPath: item)
                        
                        guard let image = NSImage(contentsOf: itemURL) else { return }
                        
                        let title = url.lastPathComponent.components(separatedBy: ".")[0]
                        
                        Photo.new(image: image, title: title, shortDescription: nil, longDescription: nil, dateTaken: nil, location: nil)
                    }
                    
                    dump(filtered)
                } catch {
                    print(error.localizedDescription)
                }
                
                self.finishImport()
            }
            
        }
        
    }
    
    @IBAction func addDirectoryTreeButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel()
        
        dialog.title = "Select a directory of photos"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        
        if dialog.runModal() == NSModalResponseOK {
            
            operationQueue.addOperation {
                
                guard let url = dialog.url else { return }
                
                self.saveImages(in: url.path)
                
                
                do {
                    let directoryPaths = try FileManager.default.subpathsOfDirectory(atPath: url.path)
                    
                    for path in directoryPaths {
                        self.saveImages(in: url.appendingPathComponent(path).path)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
                self.finishImport()
            }
        }
    }
    
    private func saveImages(in directory: String) {
        let rootURL = URL(fileURLWithPath: directory)
        
        let contents: [String]
        
        do {
            contents = try FileManager.default.contentsOfDirectory(atPath: directory)
            
            let filtered = contents.filter({ (path) -> Bool in
                for fileType in Factbook.allowedImageFileTypes {
                    if path.hasSuffix(fileType) {
                        return true
                    }
                }
                
                return false
            })
            
            for imagePath in filtered {
                
                let url = rootURL.appendingPathComponent(imagePath)
                
                guard let image = NSImage(contentsOf: url) else { continue }
                
                let title = url.lastPathComponent.components(separatedBy: ".")[0]
                
                Photo.new(image: image, title: title, shortDescription: nil, longDescription: nil, dateTaken: nil, location: nil)
                
                
            }
            
        } catch {
            print(error.localizedDescription)
            return
        }
       
    }
    
    private func finishImport() {
        
        OperationQueue.main.addOperation {
            self.dismiss(self)
            
            MainWindowController.instance.photosViewController.photoCollectionView.reloadData()
        }
    }
    
    init() {
        super.init(nibName: "AddPhotosViewController", bundle: nil)!
        self.operationQueue.qualityOfService = .background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
