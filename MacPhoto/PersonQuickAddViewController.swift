//
//  PersonSelectionQuickAddViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonQuickAddViewController: NSViewController {
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var firstNameTextField: NSTextField!
    @IBOutlet weak var middleNameTextField: NSTextField!
    @IBOutlet weak var lastNameTextField: NSTextField!
    @IBOutlet weak var genderSegmentedControl: NSSegmentedControl!
    @IBOutlet weak var saveButton: NSButton!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if nameTextField.stringValue.isEmpty {
            shakeNameTextField()
            return
        }
        
        let firstName = firstNameTextField.stringValue
        let middleName = middleNameTextField.stringValue
        let lastName = lastNameTextField.stringValue
        
        let isFemale: Bool?
        
        switch genderSegmentedControl.selectedSegment {
        case 0: isFemale = true
        case 1: isFemale = false
        default: isFemale = nil
        }
        
        Person.new(name: nameTextField.stringValue,
                   firstName: firstName.isEmpty ? nil : firstName,
                   middleName: middleName.isEmpty ? nil: middleName,
                   lastName: lastName.isEmpty ? nil: lastName,
                   isFemale: isFemale)
        
        guard let person = DataStore.instance.people.last else  { return }
        delegate.add(new:person)
    }
    
    var delegate: PersonQuickAddDelegate!
    
    init(){
        super.init(nibName: "PersonQuickAddViewController", bundle: nil)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var standardFrame: NSRect = NSRect(x: 0, y: 0, width: 480, height: 480)
    
    func shakeNameTextField() {
        
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        
        animation.values = [20,5,35,20]
        animation.keyTimes = [0,0.33,0.67,1]
        animation.duration = 0.3
        animation.repeatCount = 1
        
        nameTextField.layer?.add(animation, forKey: "position.x")
    }
    
}
