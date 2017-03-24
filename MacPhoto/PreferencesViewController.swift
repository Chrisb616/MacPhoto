//
//  PreferencesViewController.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/23/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {
    
    weak var delegate: PreferencesDelegate?
    
    @IBOutlet weak var pathControl: NSPathControl!
    var pathControlClickRegognizer = NSClickGestureRecognizer()
    
    init() {
        super.init(nibName: "PreferencesViewController", bundle: nil)!
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializePathControl() {
        pathControl.url = LocalFileManager.instance.programDirectoryHome
        
        pathControl.addGestureRecognizer(pathControlClickRegognizer)
        pathControlClickRegognizer.numberOfClicksRequired = 2
        pathControlClickRegognizer.action = #selector(pathControlClicked)
    }
    
    @objc private func pathControlClicked(_ sender: NSClickGestureRecognizer) {
        print("Path")
        
        let dialog = NSOpenPanel()
        
        dialog.title = "Select New Program Directory"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = true
        dialog.canChooseFiles = false
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = false
        
        if dialog.runModal() == NSModalResponseOK {
            let result = dialog.url
            
            if let url = result {
                
                if url.path.hasSuffix("MacPhoto") {
                    let newURL = url.deletingLastPathComponent()
                    
                    LocalFileManager.instance.saveProgramDirectoryHome(at: newURL)
                    pathControl.url = newURL
                    
                } else {
                    LocalFileManager.instance.saveProgramDirectoryHome(at: url)
                    pathControl.url = url
                }
                
                delegate?.reloadAll()
            }
            else {
                let alert = NSAlert()
                
                alert.messageText = "Could not change program directory"
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.preferredContentSize = NSMakeSize(self.view.frame.size.width, self.view.frame.size.height)
        initializePathControl()
    }
    
}
