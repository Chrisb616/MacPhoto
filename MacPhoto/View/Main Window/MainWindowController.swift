//
//  MainWindowController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/21/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    //MARK: - Toolbar Properties
    @IBOutlet weak var toolbar: NSToolbar!
    
    //MARK: - Toolbar Actions

    @IBAction func photosToolbarItemSelected(_ sender: Any) {
        show(.photos)
        activeViewController = .photos
    }
    @IBAction func peopleToolbarItemSelected(_ sender: Any) {
        show(.people)
        activeViewController = .photos
    }
    @IBAction func placesToolbarItemSelected(_ sender: Any) {
        show(.places)
        activeViewController = .places
    }
    
    @IBAction func preferencesToolbarItemSelected(_ sender: Any) {
        let preferences = PreferencesViewController()
        
        preferences.delegate = self
        
        contentViewController?.presentAsSheet(preferences)
    }
    
    @IBAction func addToolbarItemSelected(_ sender: Any) {
        let addPhotosViewController = AddPhotosViewController()
        
        contentViewController?.presentAsSheet(addPhotosViewController)
    }
    
    //MARK: - Other Properties
    static var instance: MainWindowController!
    
    let tabViewController = NSTabViewController()
    
    var activeViewController = ViewController.photos
    
    let photosViewController = PhotoViewController()
    let peopleViewController = PersonViewController()
    let placesViewController = PlacesViewController()
    
    var personDetailWindow: PersonDetailWindowController!
    
    //MARK: - Life Cycle
    override func windowDidLoad() {
        super.windowDidLoad()
        MainWindowController.instance = self
        
        ConsistencyManager.check()
        
        window?.styleMask.insert(NSWindow.StyleMask.resizable)

        instantiateTabViewController()
        
        self.window?.delegate = self
    }
    
    //MARK: - View Methods
    func instantiateTabViewController() {
        tabViewController.view.wantsLayer = true
        tabViewController.tabStyle = .unspecified
        
        tabViewController.addChild(photosViewController)
        tabViewController.addChild(peopleViewController)
        tabViewController.addChild(placesViewController)
        self.window?.contentViewController = tabViewController
    }
    
    func show(_ viewController: ViewController) {
        tabViewController.selectedTabViewItemIndex = viewController.index
    }
    
    func showPersonDetailWindow(for person: Person) {
        personDetailWindow = PersonDetailWindowController.init(windowNibName: "PersonDetailWindowController")
        personDetailWindow.person = person
    
        personDetailWindow.showWindow(self)
    }

}

extension MainWindowController: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        NSApplication.shared.terminate(self)
    }
    
}

extension MainWindowController: PreferencesDelegate {
    
    func reloadAll() {
        DataStore.instance.clear()
        LocalFileManager.instance.loadAllInfo()
        photosViewController.photoCollectionView.reloadData()
    }
    
}

extension MainWindowController {
    enum ViewController {
        case photos
        case people
        case places
        
        var index: Int {
            switch self {
            case .photos: return 0
            case .people: return 1
            case .places: return 2
            }
        }
    }
}
