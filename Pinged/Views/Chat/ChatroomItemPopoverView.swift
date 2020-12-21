//
//  ChatroomItemPopoverView.swift
//  Cartisim
//
//  Created by Cole M on 12/10/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatroomItemPopoverView: NSView {

    let stackView: NSStackView = {
        var stk = NSStackView()
        stk.orientation = .horizontal
        stk.alignment = .bottom
        return stk
    }()
    
    let deleteButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.title = "Delete Message"
        btn.contentTintColor = .white
        return btn
    }()

    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        buildScroll()
        anchors()
    }
    
    deinit {
        print("Memory Reclaimed in ChatsView")
    }
    
    
    fileprivate func buildScroll() {
        wantsLayer = true
        addSubview(stackView)
        stackView.addArrangedSubview(deleteButton)
        stackView.orientation = .vertical
        stackView.alignment = .centerX
        
    }
    
    fileprivate func anchors() {
        stackView.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 5, paddingRight: 0, width: 150, height: 20)
        deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
