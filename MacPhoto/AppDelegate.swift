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
        
        LocalFileManager.instance.loadPersonInfo()
        //Person.new(name: "Evy", firstName: "Evelyn", middleName: "Claire", lastName: "Miller")
        //LocalFileManager.instance.savePersonInfo()
        dump(DataStore.instance.people.at(index: 0))
        dump(DataStore.instance.people.at(index: 1))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

