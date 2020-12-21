//
//  NSScrollView+Extension.swift
//  Cartisim
//
//  Created by Cole M on 8/31/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

final class MyScrollView: NSScrollView {
   
    override func addSubview(_ view: NSView) {
        self.backgroundColor = NSColor(cgColor: Constants.DARK_CHARCOAL_COLOR)!
        self.wantsLayer = true
        self.layer?.backgroundColor = Constants.DARK_CHARCOAL_COLOR
        self.drawsBackground = false
        self.verticalScroller?.isEnabled = false
        self.horizontalScroller?.isEnabled = false
        super.addSubview(view)
    }
}

final class ClearScrollView: NSScrollView {
    override func addSubview(_ view: NSView) {
        self.drawsBackground = false
        self.wantsLayer = true
        self.layer?.backgroundColor = .clear
        self.verticalScroller?.isEnabled = false
        self.horizontalScroller?.isEnabled = false
        super.addSubview(view)
    }
}
