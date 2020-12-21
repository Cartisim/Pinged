//
//  NSTextField+Extension.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension NSTextField {
    
    /// Return an `NSTextField` configured exactly like one created by dragging a “Label” into a storyboard.
    class func newLabel() -> NSTextField {
        let label = NSTextField()
        label.wantsLayer = true
        label.isEditable = false
        label.isSelectable = false
        label.backgroundColor = .clear
        label.isBordered = false
        label.textColor = .white
        label.drawsBackground = false
        label.isBezeled = false
        label.alignment = .natural
        label.font = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: label.controlSize))
//        label.lineBreakMode = .byClipping
        label.cell?.isScrollable = true
        label.cell?.wraps = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }
    
    /// Return an `NSTextField` configured exactly like one created by dragging a “Wrapping Label” into a storyboard.
    class func newWrappingLabel() -> NSTextField {
        let label = newLabel()
        label.lineBreakMode = .byWordWrapping
        label.cell?.isScrollable = true
        label.cell?.wraps = true
        label.maximumNumberOfLines = 60
        return label
    }
}
