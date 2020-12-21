//
//  ContactItemView.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ContactItemView: NSView {
    
    let name: NSTextField = {
        let lb = NSTextField.newLabel()
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        return lb
    }()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(name)
        name.anchors(top: topAnchor, leading: leadingAnchor, bottom:bottomAnchor, trailing: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}

