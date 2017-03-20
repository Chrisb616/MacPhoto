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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        Person.new(name: "Chris", firstName: "Christopher", middleName: "Alexander", lastName: "Boynton")
        Person.new(name: "James", firstName: "James", middleName: nil, lastName: "Bond")
        Person.new(name: "Marco", firstName: "Marco", middleName: nil, lastName: "Polo")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

