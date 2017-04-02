//
//  PhotoCollectionViewItem.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/7/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PhotoCollectionViewItem: NSCollectionViewItem, NSGestureRecognizerDelegate {
    
    var photo: Photo?
    var index: Int!
    
    func load(photo: Photo, index: Int) {
        self.photo = photo
        self.index = index
        reload()
    }
    
    func reload() {
        guard let unwrappedPhoto = photo else { print("WARNING: No photo found for collection view item"); return }
        
        imageView?.image = unwrappedPhoto.image
        textField?.stringValue = unwrappedPhoto.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer = CALayer()
        
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        print(event.clickCount)
        
        if event.clickCount > 1 {
            guard let unwrappedPhoto = photo else { print("WARNING: No photo found for collection view item"); return }
            
            let detailVC = PhotoDetailViewController(photo: unwrappedPhoto, photoIndex: index)
            
            presentViewControllerAsSheet(detailVC)
        }
    }
    
    
}
