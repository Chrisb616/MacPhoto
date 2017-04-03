//
//  PersonDetailViewController.swift
//  MacPhoto
//
//  Created by Admin on 4/3/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonDetailViewController: NSViewController {
    
    private var windowController: PersonDetailWindowController
    
    private var person: Person!
    
    init(windowController: PersonDetailWindowController) {
        self.windowController = windowController
        super.init(nibName: "PersonDetailViewController", bundle: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func loadPerson() {
        
    }
    
}
