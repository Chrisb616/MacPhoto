//
//  PersonSelectionViewDelegate.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/10/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

protocol PersonSelectionViewDelegate: class {
    func added(_ person: Person)
    func removed(_ person: Person)
}
