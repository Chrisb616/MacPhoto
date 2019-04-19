//
//  PhotoDetailViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/9/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PhotoDetailViewController: NSViewController {
    
    var personSelectionViewController: PersonSelectionViewController!
    
    var photo: Photo
    
    var photoIndex: Int

    @IBOutlet weak var photoImageView: NSImageView!

    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var personSelectionContainer: NSView!
    
    @IBOutlet weak var uniqueIDLabel: NSTextField!
    
    @IBOutlet weak var previousButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        if photoIndex == 0 {
            photoIndex = DataStore.instance.photos.count - 1
        } else {
            photoIndex = photoIndex - 1
        }
        self.photo = DataStore.instance.photos.at(index: photoIndex)
        
        reload()
        
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        if photoIndex == DataStore.instance.photos.count - 1 {
            self.photoIndex = 0
        } else {
            self.photoIndex = photoIndex + 1
        }
        self.photo = DataStore.instance.photos.at(index: photoIndex)
        
        reload()
    }
    
    init(photo: Photo, photoIndex: Int) {
        self.photo = photo
        self.photoIndex = photoIndex
        super.init(nibName: "PhotoDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        self.photo.title = titleTextField.stringValue
        LocalFileManager.instance.savePhotoInfo()
        self.dismiss(nil)
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        
        MainWindowController.instance.photosViewController.photoCollectionView.reloadData()
    }
    
    func reload() {
        self.photoImageView.image = photo.image
        self.titleTextField.stringValue = photo.title
        self.uniqueIDLabel.stringValue = photo.uniqueID
        
        self.titleTextField.delegate = self
        
        personSelectionViewController = PersonSelectionViewController()
        personSelectionViewController.delegate = self
        personSelectionViewController.populate(selectedPeople: photo.people)
        personSelectionViewController.placeIn(container: personSelectionContainer)
        
    }
    
}

extension PhotoDetailViewController: PersonSelectionViewDelegate {
    func added(_ person: Person) {
        print("Added \(person.fullName)")
        photo.associate(person: person)
    }
    func removed(_ person: Person) {
        print("Removed \(person.fullName)")
        photo.disassociate(person: person)
    }
}

extension PhotoDetailViewController: NSTextFieldDelegate {
    /*
    override func controlTextDidChange(_ obj: Notification) {
        photo.title = titleTextField.stringValue
    }
 */
    
}
