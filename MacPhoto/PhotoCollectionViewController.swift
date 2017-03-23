//
//  PhotoCollectionViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PhotoCollectionViewController: NSViewController {

    @IBOutlet weak var photoCollectionView: NSCollectionView!
    @IBOutlet weak var photoCollectionViewLayout: NSCollectionViewFlowLayout!
    
    var pathControlClickHandler: NSClickGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        configureCollectionView()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    
    }
    
    private func configureCollectionView() {
        photoCollectionViewLayout.itemSize = NSSize(width: 160, height: 140)
        photoCollectionViewLayout.sectionInset = NSEdgeInsetsMake(10, 20, 10, 20)
        photoCollectionViewLayout.minimumLineSpacing = 20
        photoCollectionViewLayout.minimumInteritemSpacing = 20
        photoCollectionView.collectionViewLayout = photoCollectionViewLayout
        
        view.wantsLayer = true
        
        photoCollectionView.layer = CALayer()
        photoCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        
    }

}

extension PhotoCollectionViewController: NSCollectionViewDataSource {
    
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

extension PhotoCollectionViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
    }
    
}
