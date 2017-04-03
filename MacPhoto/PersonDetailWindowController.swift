//
//  PersonDetailWindowController.swift
//  MacPhoto
//
//  Created by Admin on 4/3/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonDetailWindowController: NSWindowController {
    
    let personDetailViewController = PersonDetailViewController()
    
    let tabViewController = NSTabViewController()
    
    override func windowDidLoad() {
        super.windowDidLoad()

        instantiateTabViewController()
    }
    
    func instantiateTabViewController() {
        tabViewController.view.wantsLayer = true
        tabViewController.tabStyle = .unspecified
        
        tabViewController.addChildViewController(personDetailViewController)
        self.window?.contentViewController = tabViewController
        
        
    }
    
}
