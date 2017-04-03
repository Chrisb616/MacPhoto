//
//  PersonDetailWindow.swift
//  MacPhoto
//
//  Created by Admin on 4/3/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonDetailWindowController: NSWindowController {
    
    var personDetailViewController: PersonDetailViewController!
    
    let tabViewController = NSTabViewController()
    
    var person: Person!
    
    @IBOutlet var personDetailWindow: NSWindow!
    
    
    override func windowDidLoad() {
        super.windowDidLoad()

        //instantiateTabViewController()
    }
    func instantiateTabViewController() {
        tabViewController.view.wantsLayer = true
        tabViewController.tabStyle = .unspecified
        
        tabViewController.addChildViewController(personDetailViewController)
        self.window?.contentViewController = tabViewController
        
        
    }
    
    func load(_ person: Person) {
        //personDetailViewController.loadPerson()
    }
    
}
