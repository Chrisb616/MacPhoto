//
//  AddPhotosViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/31/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class AddPhotosViewController: NSViewController {
    
    private var localFileManager = LocalFileManager.instance
    
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
        
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            
            guard let url = dialog.url else { return }
            
            localFileManager.importPhoto(from: url)
            
            dismiss(self)
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
        
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            
            localFileManager.importPhotos(from: dialog.urls)
            dismiss(self)
            
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
        
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            
            guard let url = dialog.url else { return }
            
            importContents(ofDirectory: url)
            
            dismiss(self)
            
        }
        
    }
    
    func importContents(ofDirectory url: URL) {
        
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: url.path)
            
            var filtered = [URL]()
            
            for path in contents {
                for fileType in Factbook.allowedImageFileTypes {
                    if path.hasSuffix(fileType) {
                        filtered.append(url.appendingPathComponent(path))
                    }
                }
            }
            
            localFileManager.importPhotos(from: filtered)
            
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss(self)
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
        
        if dialog.runModal() == NSApplication.ModalResponse.OK {
            
            guard let url = dialog.url else { return }
            
            FileManager.default.listFiles(path: url.path, completion: { (urls) in
                LocalFileManager.instance.importPhotos(from: urls)
                
                self.dismiss(self)
            })
            
            
        }
    }
    
    init() {
        super.init(nibName: "AddPhotosViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func dismiss(_ sender: Any?) {
        OperationQueue.main.addOperation {
            super.dismiss(sender)
        }
    }
    
    
}
