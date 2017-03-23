//
//  MainWindowController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/21/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    //MARK: - Toolbar Properties
    @IBOutlet weak var toolbar: NSToolbar!
    
    //MARK: - Toolbar Actions

    @IBAction func photosToolbarItemSelected(_ sender: Any) {
        print("Photos")
    }
    @IBAction func peopleToolbarItemSelected(_ sender: Any) {
        print("People")
    }
    @IBAction func placesToolbarItemSelected(_ sender: Any) {
        print("Places")
    }
    
    @IBAction func preferencesToolbarItemSelected(_ sender: Any) {
        contentViewController?.presentViewControllerAsSheet(PreferencesViewController())
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        LocalFileManager.instance.loadAllInfo()
        
        window?.styleMask.insert(NSWindowStyleMask.resizable)
    }

    
}
