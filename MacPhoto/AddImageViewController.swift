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
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let image = addImageWell.image {
            Photo.new(image: image, title: titleTextField.stringValue, shortDescription: shortDescriptionTextView.string, longDescription: longDescriptionTextView.string, dateTaken: dateTakenDatePicker.dateValue, location: nil)
            LocalFileManager.instance.savePhotoInfo()
        } else {
            print("No image found, please drag an image into the well.")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        
    }
    
}
