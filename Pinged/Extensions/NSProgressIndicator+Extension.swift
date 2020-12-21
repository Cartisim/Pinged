//
//  NSProgressIndicator+Extension.swift
//  Cartisim
//
//  Created by Cole M on 10/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa


extension NSProgressIndicator {
    func spinner(indicator: NSProgressIndicator, constraint: NSLayoutXAxisAnchor) {
        indicator.wantsLayer = true
        indicator.style = .spinning
        indicator.controlSize = .regular
        indicator.centerXAnchor.constraint(equalTo: constraint).isActive = true
        indicator.stopAnimation(self)
        indicator.isHidden = true
    }
    
    func hide(indicator: NSProgressIndicator) {
        indicator.isHidden = true
        indicator.stopAnimation(self)
    }
    
    func show(indicator: NSProgressIndicator) {
        indicator.isHidden = false
        indicator.startAnimation(self)
    }
}
