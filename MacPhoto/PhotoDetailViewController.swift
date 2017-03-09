//
//  PhotoDetailViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/9/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PhotoDetailViewController: NSViewController {

    @IBOutlet weak var photoImageView: NSImageView!
    var photo: Photo

    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: "PhotoDetailViewController", bundle: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoImageView.image = photo.image
    }
    
}
