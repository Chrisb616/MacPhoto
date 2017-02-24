//
//  CSVContent.swift
//  MacPhoto
//
//  Created by Christopher Boynton on 2/24/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Foundation

struct CSVContent {
    
    
    //MARK: - Initialization Logic
    init(_ string: String) {
        var content = parse(string)
        normalize(&content)
        
        self.content = content
    }
    
    private func parse(_ string: String) -> [[String]] {
        var content = [[String]]()
        
        let lines = string.components(separatedBy: "\n")
        
        for line in lines {
            let cells = line.components(separatedBy: ",")
            
            content.append(cells)
        }
        
        return content
    }
    
    private func normalize(_ content: inout [[String]], toRowLength rowLength: Int = 0) {
        var rowLength = rowLength
        
        for (index, immutableRow) in content.enumerated() {
            var row = immutableRow
            
            if rowLength < row.count {
                rowLength = row.count
                normalize(&content, toRowLength: rowLength)
                return
            }
            while rowLength > row.count {
                row.append("")
            }
            
            content[index] = row
        }
    }
    
    
    //MARK: - Content
    private var content = [[String]]()
    
    var numOfRows: Int { return content.count }
    var numOfColumns: Int { return content.first!.count }
    
    //MARK: - Data Access
    func at(row index: Int) -> [String] {
        
        if numOfRows > index {
            return content[index]
        } else {
            print("FAILURE: No index for row \(index)")
            return []
        }
        
    }
    
    func at(column index: Int) -> [String] {
        var column = [String]()
        
        if numOfColumns <= index { print("FAILURE: No index for column \(index)"); return [] }
        
        for row in content {
            column.append(row[index])
        }
        
        return column
    }
    
    func at(row rowIndex: Int, column columnIndex: Int) -> String? {
        let row = self.at(row: rowIndex)
        
        if numOfColumns <= columnIndex { print("FAILURE: No index for column \(index) in row \(rowIndex)"); return nil }
        
        return row[columnIndex]
    }

    
    
}
