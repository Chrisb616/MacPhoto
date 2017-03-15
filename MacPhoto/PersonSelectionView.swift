//
//  PersonSelectionView.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/10/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonSelectionView: NSViewController {
    
    weak var delegate: PersonSelectionViewDelegate?
    var people: [String:Bool]
    
    init(people: [String:Bool]){
        self.people = people
        super.init(nibName: "PersonSelectionView", bundle: nil)!
    }
    convenience init(){
        self.init(people:[:])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension PersonSelectionView: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return DataStore.instance.people.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell = tableView.make(withIdentifier: "personCell", owner: nil) as? PersonSelectionTableCellView {
            let person = DataStore.instance.people.at(index: row)
            
            cell.initializeCheckBox()
            cell.set(person: person)
            
            if people[person.uniqueID] != nil {
                cell.check.state = 1
            }
            
            cell.set(delegate: delegate)
            return cell
        }
        return nil
    }
}
