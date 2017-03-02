//
//  AddImageViewController.swift
//  MacPhoto
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class AddImageViewController: NSViewController {

    @IBOutlet weak var addImageWell: NSImageView!
    
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet var shortDescriptionTextView: NSTextView!
    @IBOutlet var longDescriptionTextView: NSTextView!
    @IBOutlet weak var dateTakenDatePicker: NSDatePicker!
    
    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var openButton: NSButton!
    @IBOutlet weak var pathControl: NSPathControl!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let image = addImageWell.image {
            Photo.new(image: image,
                      title: titleTextField.stringValue,
                      shortDescription: shortDescriptionTextView.string,
                      longDescription: longDescriptionTextView.string,
                      dateTaken: dateTakenDatePicker.dateValue,
                      spot: nil)
            LocalFileManager.instance.savePhotoInfo()
        } else {
            print("WARING: No image found, please drag an image into the well.")
        }
        
        
    }
    @IBAction func openButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel()
        
        dialog.title = "Testing Testing"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["png"]
        
        if dialog.runModal() == NSModalResponseOK {
            let result = dialog.url
            
            if let result = result {
                pathControl.url = result
            }
        }
    }
    @IBAction func addImageWellActivated(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        pathControl.url = nil

    }
    
}
