//
//  StartupService.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 4/22/19.
//  Copyright © 2019 Christopher Boynton. All rights reserved.
//

import Foundation

class StartupService {
    
    static var instance: StartupService = StartupService()
    private init() {}
    
    func onStartup(_ completion: @escaping ()->()) {
    }
    
    func onWindowLoad(_ completion: @escaping ()->()) {
        
        LocalFileManager.instance.loadAllInfo {
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
