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
    @IBOutlet weak var closeButton: NSButton!
    @IBOutlet weak var collapseDateTakenButton: NSButton!
    @IBOutlet weak var pathControl: NSPathControl!
    
    var unchangedDate = Date()
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let image = addImageWell.image {
            Photo.new(image: image,
                      title: titleTextField.stringValue,
                      shortDescription: shortDescriptionTextView.string,
                      longDescription: longDescriptionTextView.string,
                      dateTaken: dateTakenDatePicker.isHidden ? nil : dateTakenDatePicker.dateValue,
                      location: nil)
            
            LocalFileManager.instance.savePhotoInfo()
        } else {
            print("WARING: No image found, please drag an image into the well.")
        }
        
        
    }
    @IBAction func openButtonTapped(_ sender: Any) {
        let dialog = NSOpenPanel()
        
        dialog.title = "Select File to import"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canChooseFiles = true
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["jpeg","jpg","png"]
        
        if dialog.runModal() == NSModalResponseOK {
            let result = dialog.url
            
            if let result = result {
                pathControl.url = result
                let image = NSImage(contentsOf: result)
                print("\(image?.size.width)x\(image?.size.height)")
                addImageWell.image = image
            }
        }
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(sender)
    }
    @IBAction func collapseDateTakenButtonTapped(_ sender: Any) {
        if dateTakenDatePicker.isHidden {
            dateTakenDatePicker.isHidden = false
            collapseDateTakenButton.image = NSImage(named: "NSRemoveTemplate")
        } else {
            dateTakenDatePicker.isHidden = true
            collapseDateTakenButton.image = NSImage(named: "NSAddTemplate")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        pathControl.url = nil
        

    }
    
}
