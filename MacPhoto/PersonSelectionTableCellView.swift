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
    
    private weak var delegate: PersonSelectionViewDelegate?
    private weak var person: Person!

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func initializeCheckBox() {
        self.layer?.backgroundColor = NSColor.red.cgColor
        check = NSButton()
        self.addSubview(check)
        check.frame = self.frame
        check.setButtonType(.switch)
        check.target = self
        check.action = #selector(selected)

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
            delegate?.removed(person)
        } else if sender.state == 1 {
            delegate?.added(person)
        }
    }
    
}
