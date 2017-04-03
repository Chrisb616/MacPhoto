//
//  PersonDetailViewController.swift
//  MacPhoto
//
//  Created by Admin on 4/3/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonDetailViewController: NSViewController {
    
    var window: PersonDetailWindowController!

    @IBOutlet weak var defaultPhotoBox: NSBox!
    @IBOutlet weak var defaultPhotoImageView: NSImageView!
    var defaultPhotoImageViewClickRecognizer: NSClickGestureRecognizer!
    var defaultPhotoImageViewWasClicked: Bool = false
    
    @IBOutlet weak var nameAndNicknameTextField: NSTextField!
    
    
    init() {
        super.init(nibName: "PersonDetailViewController", bundle: nil)!
        
    }
    
    func configureGuestures() {
        
        defaultPhotoImageViewClickRecognizer = NSClickGestureRecognizer(target: self, action: #selector(defaultPhotoImageViewClicked))
        defaultPhotoImageView.addGestureRecognizer(defaultPhotoImageViewClickRecognizer)
    }
    
    
    @objc func defaultPhotoImageViewClicked() {
        self.view.addSubview(defaultPhotoBox, positioned: NSWindowOrderingMode.above, relativeTo: nil)
        
        if defaultPhotoImageViewWasClicked {
            
            defaultPhotoBox.frame = NSRect(x: 0, y: 780, width: 300, height: 300)
            defaultPhotoImageViewWasClicked = false
        } else {
            defaultPhotoBox.frame = self.view.frame
            defaultPhotoImageViewWasClicked = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPersonInfo()
        configureGuestures()
        
        configureTextField()
    }
    
    func configureTextField() {
        nameAndNicknameTextField.resizeFontToCurrentFrame()
    }
    
    func loadPersonInfo() {
        
        guard let person = window.person else { print("FAILURE: Could not retrieve person for detail view"); return }
        
        defaultPhotoImageView.image = person.randomPhoto?.image
        
        
    }
    
    
    
}
