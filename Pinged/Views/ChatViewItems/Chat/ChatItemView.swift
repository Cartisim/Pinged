//
//  ChatItemView.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatItemView: NSView {

    let avatar: NSImageView = {
        let imgv = NSImageView()
        imgv.imageAlignment = .alignLeft
        imgv.imageScaling = .scaleNone
        imgv.layer?.cornerRadius = 10
        return imgv
    }()
    
    let name: NSTextField = {
        let lb = NSTextField.newLabel()
        lb.lineBreakMode = .byTruncatingTail
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        return lb
    }()
    
    let message: NSTextField = {
        let msg = NSTextField.newWrappingLabel()
        msg.maximumNumberOfLines = 10
        return msg
    }()
    
    let dateLabel: NSTextField = {
        let dt = NSTextField.newLabel()
        dt.font = .systemFont(ofSize: 12, weight: .light)
        return dt
    }()
    
    let optionsButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.contentTintColor = Constants.OFF_WHITE_COLOR
        btn.image = NSImage(named: "NSIconViewTemplate")
        return btn
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
        addSubview(avatar)
        addSubview(name)
        addSubview(message)
        addSubview(dateLabel)
        addSubview(optionsButton)

        avatar.anchors(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 70, height: 0)
        name.anchors(top: topAnchor, leading: avatar.trailingAnchor, bottom:nil, trailing: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: 0)
        message.greaterThanAnchors(top: name.bottomAnchor, leading: avatar.trailingAnchor, bottom:nil, trailing: trailingAnchor, paddingTop: 15, paddingLeft: 40, paddingBottom: 20, paddingRight: 200, width: 0, height: 0)
        dateLabel.anchors(top: message.bottomAnchor, leading: message.trailingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 0)
        optionsButton.anchors(top: dateLabel.bottomAnchor, leading: nil, bottom: nil, trailing: dateLabel.trailingAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0)
    }
    
}
