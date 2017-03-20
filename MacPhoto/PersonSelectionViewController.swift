//
//  PersonSelectionView.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/10/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PersonSelectionViewController: NSViewController {
    
    weak var delegate: PersonSelectionViewDelegate?
    var selected = [String:Bool]()
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var searchField: NSSearchField!
    
    var people = [Person]()
    
    init(){
        super.init(nibName: "PersonSelectionViewController", bundle: nil)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func populate(selectedPeople: [String:Bool]) {
        people = DataStore.instance.people.all
        selected = selectedPeople
    }

    func placeIn(container: NSView) {
        container.addSubview(self.view)
    }
    
}

extension PersonSelectionViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell = tableView.make(withIdentifier: "personCell", owner: nil) as? PersonSelectionTableCellView {
            let person = people[row]
            
            cell.initializeCheckBox()
            cell.set(person: person)
            
            if selected[person.uniqueID] != nil { cell.check.state = 1}
            
            cell.set(delegate: delegate)
            cell.refreshLayer()
            return cell
        }
        return nil
    }
}

extension PersonSelectionViewController: NSSearchFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        let search = searchField.stringValue
        let allPeople = DataStore.instance.people.all
        
        if search == "" {
            people = allPeople
            tableView.reloadData()
            return
        }
        
        people = allPeople.filter({ (person) -> Bool in
            return person.name.contains(search)
        })
    
        tableView.reloadData()
        
        
    }
    
}
