//
//  ViewImagesViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/25/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class ViewImagesViewController: NSViewController {

    @IBOutlet weak var collectionView: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 160.0, height: 140.0)
        flowLayout.sectionInset = NSEdgeInsetsMake(10.0, 20.0, 10.0, 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        collectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
        
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
    }
    
}

extension ViewImagesViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataStore.instance.photos.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? PhotoCollectionViewItem else { return item }
        
        return collectionViewItem
    }
    
}
