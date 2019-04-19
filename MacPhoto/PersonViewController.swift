//
//  PhotoViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/23/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonViewController: NSViewController {
    
    @IBOutlet weak var personCollectionView: NSCollectionView!
    @IBOutlet weak var personCollectionViewLayout: NSCollectionViewFlowLayout!
    @IBOutlet weak var personListView: NSView!
    
    init() {
        super.init(nibName: "PersonViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pathControlClickHandler: NSClickGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocalFileManager.instance.loadPersonInfo {
            self.personCollectionView.reloadData()
        }
        configureCollectionView()
        configurePersonListView()

    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        personCollectionView.reloadData()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
        
    }
    
    private func configureCollectionView() {
        personCollectionViewLayout.itemSize = NSSize(width: 160, height: 140)
        personCollectionViewLayout.sectionInset = NSEdgeInsetsMake(10, 10, 10, 10)
        personCollectionViewLayout.minimumLineSpacing = 0
        personCollectionViewLayout.minimumInteritemSpacing = 0
        personCollectionView.collectionViewLayout = personCollectionViewLayout
        
        personCollectionView.wantsLayer = true
        
        personCollectionView.layer = CALayer()
        personCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        
    }
    
    private func configurePersonListView() {
        let layer = CALayer()
        
        layer.backgroundColor = NSColor(calibratedRed: 144/255, green: 0/255, blue: 31/255, alpha: 1).cgColor
        
        personCollectionView.layer = layer
    }
    
}

extension PersonViewController: NSCollectionViewDataSource {
     
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStore.instance.people.count
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "PersonCollectionViewItem"), for: indexPath)
        guard let collectionViewItem = item as? PersonCollectionViewItem else { return item }
        
        let person = DataStore.instance.people.at(index: indexPath.item)
        collectionViewItem.load(person: person, index: indexPath.item)
        return collectionViewItem
    }
}

extension PersonViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    }
    
}

