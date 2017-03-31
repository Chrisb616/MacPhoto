//
//  Factbook.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

struct Factbook {
    
    static var documentsPath: String { return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] }
    static var picturesPath: String { return NSSearchPathForDirectoriesInDomains(.picturesDirectory, .userDomainMask, true)[0] }
    
    
    static var allowedImageFileTypes: [String] {
        return ["jpeg", "jpg", "png"]
    }
}
