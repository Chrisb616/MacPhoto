//
//  Date.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 3/4/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

extension Date {
    
    static var standardFormat: String = "YYYY_MM_dd_HH_mm_sszzz"
    
    private static var standardFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = standardFormat
        return dateFormatter
    }
    
    static func from(standardFormatString string: String) -> Date? {
        return standardFormatter.date(from: string)
    }
    
    var standardFormatString: String {
        return Date.standardFormatter.string(from: self)
    }
    
}
