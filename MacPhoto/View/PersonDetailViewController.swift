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
    
    @IBOutlet weak var nameTextField: NSTextField!
    
    @IBOutlet weak var firstNameTextField: NSTextField!
    @IBOutlet weak var middleNameTextField: NSTextField!
    @IBOutlet weak var lastNameTextField: NSTextField!
    
    
    @IBAction func bombButtonTapped(_ sender: Any) {
        DataStore.instance.people.remove(window.person)
        window.close()
    }
    
    init() {
        super.init(nibName: "PersonDetailViewController", bundle: nil)
        
    }
    
    
    
    @objc func defaultPhotoImageViewClicked() {
        self.view.addSubview(defaultPhotoBox, positioned: NSWindow.OrderingMode.above, relativeTo: nil)
        
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
        
    }
    
    override func viewWillDisappear() {
        MainWindowController.instance.peopleViewController.personCollectionView.reloadData()
    }
    
    func loadPersonInfo() {
        
        guard let person = window.person else { print("FAILURE: Could not retrieve person for detail view"); return }
        
        defaultPhotoImageView.image = person.randomPhoto?.image
        
        nameTextField.stringValue = person.name
        
        if let first = person.firstName {
            firstNameTextField.stringValue = first
        } else {
            firstNameTextField.stringValue = ""
        }
        
        if let middle = person.middleName {
            middleNameTextField.stringValue = middle
        } else {
            middleNameTextField.stringValue = ""
        }
        
        if let last = person.lastName {
            lastNameTextField.stringValue = last
        } else {
            lastNameTextField.stringValue = ""
        }
    }
    
    func configureGuestures() {
        
        defaultPhotoImageViewClickRecognizer = NSClickGestureRecognizer(target: self, action: #selector(defaultPhotoImageViewClicked))
        defaultPhotoImageView.addGestureRecognizer(defaultPhotoImageViewClickRecognizer)
    }

}

extension PersonDetailViewController: NSTextFieldDelegate {
    
    func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else { return }
        guard let person = window.person else { return }
        guard let identifier = textField.identifier?.rawValue else { return }
        
        switch identifier {
        case "name": person.name = textField.stringValue
        case "first": person.firstName = textField.stringValue
        case "middle": person.middleName = textField.stringValue
        case "last": person.lastName = textField.stringValue
        default: return
        }
    }
}
