//
//  NSTextField.swift
//  MacPhoto
//
//  Created by Admin on 4/3/17.
//  Copyright © 2017 Christopher Boynton. All rights reserved.
//

import Cocoa

extension NSTextField {
    
    func resizeFontToCurrentFrame() {
        
        guard let fontSize = font?.pointSize else { return }
        
        if firstBaselineOffsetFromTop - fontSize > 1 {
            Swift.print("Greater than \(baselineOffsetFromBottom)")
            lowerFontSize()
        } else if baselineOffsetFromBottom - fontSize < 1 {
            Swift.print("Less than: \(baselineOffsetFromBottom)")
            
        } else {
            Swift.print("Just Right")
        }
    }
    
    private func lowerFontSize() {
        guard let fontSize = font?.pointSize else { return }
        guard let fontName = font?.fontDescriptor else { return }
        
        Swift.print(fontSize)
        
        let newFont = NSFont(descriptor: fontName, size: fontSize - 1)
        
        self.font = newFont
        
        resizeFontToCurrentFrame()
        
    }
    
}

