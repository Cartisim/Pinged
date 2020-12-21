//
//  SettingsView.swift
//  Pinged
//
//  Created by Cole M on 12/18/20.
//

import Cocoa

class SettingsView: NSView {

    let stackView: NSStackView = {
        var stk = NSStackView()
        stk.orientation = .horizontal
        stk.alignment = .bottom
        return stk
    }()
    
    let authButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.title = "Authenticate"
        btn.contentTintColor = .white
        return btn
    }()
    let logoutButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.title = "Logout"
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
        print("Memory Reclaimed in SettingsView")
    }
    
    
    fileprivate func buildScroll() {
        wantsLayer = true
        addSubview(stackView)
        stackView.addArrangedSubview(authButton)
        stackView.addArrangedSubview(logoutButton)
        stackView.orientation = .vertical
        stackView.alignment = .centerX
        
    }
    
    fileprivate func anchors() {
        stackView.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 20)
    }
}
