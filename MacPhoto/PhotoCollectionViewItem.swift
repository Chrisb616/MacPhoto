//
//  PhotoCollectionViewItem.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/7/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PhotoCollectionViewItem: NSCollectionViewItem {
    
    func load(photo: Photo) {
        imageView?.image = photo.image
        textField?.stringValue = photo.title ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer = CALayer()
        view.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
}
