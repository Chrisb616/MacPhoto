//
//  PhotoCollectionViewItem.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/7/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonCollectionViewItem: NSCollectionViewItem, NSGestureRecognizerDelegate {
    
    var person: Person?
    var index: Int!
    
    func load(person: Person, index: Int) {
        self.person = person
        self.index = index
        reload()
    }
    
    func reload() {
        guard let unwrappedPerson = person else { print("WARNING: No photo found for collection view item"); return }
        
        imageView?.image = unwrappedPerson.randomPhoto?.image ?? NSImage()
        textField?.stringValue = unwrappedPerson.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer = CALayer()
        
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        
        if event.clickCount > 1 {
            guard let unwrappedPerson = person else { print("WARNING: No photo found for collection view item"); return }
            
            MainWindowController.instance.personDetailWindowController.load(unwrappedPerson)
            MainWindowController.instance.personDetailWindowController.showWindow(MainWindowController.instance)
        }
    }
    
    
}
