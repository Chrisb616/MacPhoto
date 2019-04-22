//
//  AppDelegate.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/20/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var windowController: MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        StartupService.instance.onStartup {
            
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
        LocalFileManager.instance.saveAllInfo()
        
    }
}

