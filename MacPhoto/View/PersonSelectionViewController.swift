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
    @IBOutlet weak var quickAddButton: NSButton!
    
    var personSelectionQuickAddViewController: PersonQuickAddViewController?
    
    @IBAction func quickAddButtonTapped(_ sender: Any) {
        
        if personSelectionQuickAddViewController == nil {
            personSelectionQuickAddViewController = PersonQuickAddViewController()
            personSelectionQuickAddViewController?.delegate = self
            
            guard let quickAdd = personSelectionQuickAddViewController else {
                print("FAILURE: Failed to load Person Selection Quick Add View Controller")
                return
            }
            
            present(quickAdd,
                                  asPopoverRelativeTo: PersonQuickAddViewController.standardFrame,
                                  of: quickAddButton,
                                  preferredEdge: NSRectEdge.minY,
                                  behavior: .applicationDefined)
            
            
            
        }
        else {
            dismissQuickAddPopover()
        }
        
    }
    
    func dismissQuickAddPopover() {
        personSelectionQuickAddViewController?.dismiss(nil)
        personSelectionQuickAddViewController = nil
    }
    
    var people = [Person]()
    
    init(){
        super.init(nibName: "PersonSelectionViewController", bundle: nil)
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
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        self.view.leftAnchor.constraint(equalTo: container.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: container.rightAnchor).isActive = true
    }
    
}

extension PersonSelectionViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "personCell"), owner: nil) as? PersonSelectionTableCellView {
            let person = people[row]
            
            cell.initializeCheckBox()
            cell.set(person: person)
            
            if selected[person.uniqueID] != nil { cell.check.state = NSControl.StateValue(rawValue: 1)}
            
            cell.set(delegate: delegate)
            cell.refreshLayer()
            return cell
        }
        return nil
    }
}

extension PersonSelectionViewController: NSSearchFieldDelegate {
    
    /*
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
 */
    
}

extension PersonSelectionViewController: PersonQuickAddDelegate {
    
    func add(new person: Person) {
        self.people = DataStore.instance.people.all
        self.selected.updateValue(true, forKey: person.uniqueID)
        self.delegate?.photo.associate(person: person)
        LocalFileManager.instance.savePhotoInfo()
        
        self.tableView.reloadData()
        self.dismissQuickAddPopover()
    }
    
}
