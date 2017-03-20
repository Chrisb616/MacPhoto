//
//  PersonSelectionTableCellView.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/15/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonSelectionTableCellView: NSTableCellView {
    
    var check: NSButton!
    var background: NSView!
    
    private weak var delegate: PersonSelectionViewDelegate?
    private weak var person: Person!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        self.wantsLayer = true
        
        // Drawing code here.
    }
    
    func initializeCheckBox() {
        background = NSView()
        
        self.addSubview(background)
        background.frame = self.frame
        
        let layer = CALayer()
        layer.bounds = self.frame
        layer.backgroundColor = NSColor.white.cgColor
        background.layer = layer
        
        check = NSButton()
        
        self.addSubview(check)
        check.frame = self.frame
        check.setButtonType(.switch)
        check.target = self
        check.action = #selector(selected)
        
    }
    func refreshLayer() {
    
    }
    
    func set(person: Person) {
        self.person = person
        check.title = person.fullName
    }
    func set(delegate: PersonSelectionViewDelegate?) {
        self.delegate = delegate
    }
    
    func selected(_ sender: NSButton) {
        if sender.state == 0 {
            delegate?.tableView(deselect: person)
        } else if sender.state == 1 {
            delegate?.tableView(select: person)
        }
    }
    
}
