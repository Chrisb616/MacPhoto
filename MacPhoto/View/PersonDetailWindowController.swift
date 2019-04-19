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
    
    var person: Person!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        personDetailViewController.window = self
        instantiateTabViewController()
    }
    
    func instantiateTabViewController() {
        tabViewController.view.wantsLayer = true
        tabViewController.tabStyle = .unspecified
        
        tabViewController.addChild(personDetailViewController)
        self.window?.contentViewController = tabViewController

    }
    
    func load(person: Person) {
        self.person = person
    }
    
}
