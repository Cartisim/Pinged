//
//  CenterHeader.swift
//  Cartisim
//
//  Created by Cole M on 12/15/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class CenterHeader: NSView,NSCollectionViewSectionHeaderView {
    
    lazy var label: NSTextField = {
        let lbl = NSTextField.newLabel()
        return lbl
    }()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
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
        addSubview(label)
        label.anchors(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.font = NSFont.systemFont(ofSize: 34)
    }
}
