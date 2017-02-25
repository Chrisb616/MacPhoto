//
//  PhotoCollectionViewItem.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/25/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PhotoCollectionViewItem: NSCollectionViewItem {
    

    var photo: Photo? {
        didSet {
            guard isViewLoaded else { return }
            if let photo = photo {
                imageView?.image = photo.image
                textField?.stringValue = photo.uniqueID
            } else {
                imageView?.image = nil
                textField?.stringValue = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    
}
