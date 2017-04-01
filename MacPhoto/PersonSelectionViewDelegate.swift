//
//  PersonSelectionViewDelegate.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/10/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

protocol PersonSelectionViewDelegate: class {
    
    var personSelectionViewController: PersonSelectionViewController! { get set }
    
    func added(_ person: Person)
    func removed(_ person: Person)
}

extension PersonSelectionViewDelegate {
    
    func tableView(select selection: Person) {
        added(selection)
        personSelectionViewController.selected[selection.uniqueID] = true
    }
    func tableView(deselect selection: Person) {
        removed(selection)
        personSelectionViewController.selected[selection.uniqueID] = nil
    }
    
}
