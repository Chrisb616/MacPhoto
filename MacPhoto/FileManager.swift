//
//  FileManager.swift
//  MacPhoto
//
//  Created by Admin on 4/2/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

extension FileManager {
    func listFiles(path: String) -> [URL] {
        let baseurl: URL = URL(fileURLWithPath: path)
        var urls = [URL]()
        enumerator(atPath: path)?.forEach({ (e) in
            guard let s = e as? String else { return }
            let relativeURL = URL(fileURLWithPath: s, relativeTo: baseurl)
            let url = relativeURL.absoluteURL
            urls.append(url)
        })
        return urls
    }
}
