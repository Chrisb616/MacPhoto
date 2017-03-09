//
//  ViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var mainCollectionView: NSCollectionView!
    @IBOutlet weak var mainCollectionViewLayout: NSCollectionViewFlowLayout!
    
    @IBAction func reloadButtonTapped(_ sender: Any) {
        mainCollectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        LocalFileManager.instance.loadPhotoInfo()
        configureCollectionView()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
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

extension ViewController: NSCollectionViewDataSource {
    
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

extension ViewController: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else { return }
        
        let photo = DataStore.instance.photos.at(index: indexPath.item)
        
        let detailVC = PhotoDetailViewController(photo: photo)
        
        presentViewControllerAsSheet(detailVC)
    }
    
}
