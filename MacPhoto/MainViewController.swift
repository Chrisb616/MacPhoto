//
//  MainViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var mainCollectionView: NSCollectionView!
    @IBOutlet weak var mainCollectionViewLayout: NSCollectionViewFlowLayout!
    
    @IBOutlet weak var pathControl: NSPathControl!
    var pathControlClickHandler: NSClickGestureRecognizer!
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        mainCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        LocalFileManager.instance.loadAllInfo()
        
        configureCollectionView()
        configurePathController()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    private func configurePathController() {
        pathControl.url = LocalFileManager.instance.programDirectoryHome
        
        pathControlClickHandler = NSClickGestureRecognizer()
        pathControlClickHandler.action = #selector(pathControlClicked)
        pathControlClickHandler.numberOfClicksRequired = 2
        pathControl.addGestureRecognizer(pathControlClickHandler)
        
    }
    @objc private func pathControlClicked() {
        let dialog = NSOpenPanel()
        
        dialog.title = "Select new directory"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        
        if dialog.runModal() == NSModalResponseOK {
            let result = dialog.url
            
            if let result = result {
                pathControl.url = result
                LocalFileManager.instance.saveProgramDirectoryHome(at: result.path)
                DataStore.instance.clear()
                LocalFileManager.instance.loadAllInfo()
                self.mainCollectionView.reloadData()
            }
        }

    }
    
    private func configureCollectionView() {
        mainCollectionViewLayout.itemSize = NSSize(width: 160, height: 140)
        mainCollectionViewLayout.sectionInset = NSEdgeInsetsMake(10, 20, 10, 20)
        mainCollectionViewLayout.minimumLineSpacing = 20
        mainCollectionViewLayout.minimumInteritemSpacing = 20
        mainCollectionView.collectionViewLayout = mainCollectionViewLayout
        
        view.wantsLayer = true
        
        mainCollectionView.layer = CALayer()
        mainCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        
    }

}

extension MainViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStore.instance.photos.count
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "PhotoCollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? PhotoCollectionViewItem else { return item }
        
        let photo = DataStore.instance.photos.at(index: indexPath.item)
        collectionViewItem.load(photo: photo)
        return collectionViewItem
    }
}

extension MainViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    }
    
}
