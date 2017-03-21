//
//  MainWindowController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/21/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.styleMask.insert(NSWindowStyleMask.resizable)
    }

}
