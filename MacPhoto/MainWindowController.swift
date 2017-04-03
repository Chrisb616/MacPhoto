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
    
    static var instance: MainWindowController!
    
    var activeViewController = ViewController.photos
    

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
        
        contentViewController?.presentViewControllerAsSheet(preferences)
    }
    
    @IBAction func addToolbarItemSelected(_ sender: Any) {
        let addPhotosViewController = AddPhotosViewController()
        
        contentViewController?.presentViewControllerAsSheet(addPhotosViewController)
    }
    override func windowDidLoad() {
        super.windowDidLoad()
        MainWindowController.instance = self
        
        LocalFileManager.instance.loadAllInfo()
        
        
        ConsistencyManager.check()
        
        window?.styleMask.insert(NSWindowStyleMask.resizable)

        instantiateTabViewController()
        
        self.window?.delegate = self
    }
    
    
    //View Controllers
    
    let tabViewController = NSTabViewController()
    
    let photosViewController = PhotoViewController()
    let peopleViewController = PersonViewController()
    let placesViewController = PlacesViewController()
    
    
    func instantiateTabViewController() {
        tabViewController.view.wantsLayer = true
        tabViewController.tabStyle = .unspecified
        
        tabViewController.addChildViewController(photosViewController)
        tabViewController.addChildViewController(peopleViewController)
        tabViewController.addChildViewController(placesViewController)
        self.window?.contentViewController = tabViewController
        
        
    }
    
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
    
    func show(_ viewController: ViewController) {
        tabViewController.selectedTabViewItemIndex = viewController.index
    }
    
    
    //Other windows
    
    var personDetailWindow: PersonDetailWindowController!
    
    func showPersonDetailWindow() {
        personDetailWindow = PersonDetailWindowController.init(windowNibName: "PersonDetailWindowController")
        
        personDetailWindow.showWindow(self)

    }

}

extension MainWindowController: NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        NSApplication.shared().terminate(self)
    }
    
}

extension MainWindowController: PreferencesDelegate {
    
    func reloadAll() {
        DataStore.instance.clear()
        LocalFileManager.instance.loadAllInfo()
        photosViewController.photoCollectionView.reloadData()
    }
    
}
