//
//  PeopleViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/23/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PeopleViewController: NSViewController {
    
    init() {
        super.init(nibName: "PeopleViewController", bundle: nil)!
        self.view.wantsLayer = true
        self.view.layer = CALayer()
        self.view.layer?.frame = self.view.frame
        self.view.layer?.backgroundColor = NSColor.blue.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
