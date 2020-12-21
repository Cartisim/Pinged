//
//  ChatroomView.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatroomView: NSView {

    var scrollView = MyScrollView()
    var stackView: NSStackView = {
        var stk = NSStackView()
        stk.orientation = .horizontal
        stk.alignment = .bottom
        return stk
    }()
    let collectionView = MyCollectionView()
    let progressIndicator: NSProgressIndicator = {
        let ind = NSProgressIndicator()
        return ind
    }()
    
    let chatroomStatus: NSTextField = {
        let txt = NSTextField.newLabel()
        txt.textColor = Constants.OFF_WHITE_COLOR
        txt.font = .systemFont(ofSize: 12, weight: .light)
        return txt
    }()
    
    let watermark: NSImageView = {
       let imageView = NSImageView()
        imageView.image = imageView.resizeImage(image: NSImage(imageLiteralResourceName: "pingedLogo"), maxSize: CGSize(width: 100, height: 100))
        return imageView
    }()
    
    let messageTextView: ScrollableTextView = {
       let view = ScrollableTextView()
        view.wantsLayer = true
        view.layer?.backgroundColor = .black
        view.textContainer.maximumNumberOfLines = 10
        view.textContainer.lineBreakMode = .byTruncatingTail
        return view
    }()
    
    let sendButton: NSButton = {
       let btn = NSButton()
        btn.title = "Send Message"
        btn.wantsLayer = true
        btn.layer?.backgroundColor = .none
        btn.contentTintColor = .white
        btn.isBordered = false
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
        print("Memory Reclaimed in ContactView")
    }
    
    
    fileprivate func buildScroll() {
        wantsLayer = true
        layer?.backgroundColor = .black
        scrollView = MyScrollView(frame: frame)
        addSubview(chatroomStatus)
        addSubview(scrollView)
       
        scrollView.documentView = collectionView
        collectionView.addSubview(watermark)
        addSubview(stackView)
        stackView.addArrangedSubview(messageTextView)
        stackView.addArrangedSubview(sendButton)
//        messageTextView.textView.isSelectable = false
    }
    
    fileprivate func anchors() {
        scrollView.anchors(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        scrollView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400).isActive = true
        scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
        watermark.anchors(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        watermark.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        watermark.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        chatroomStatus.anchors(top: scrollView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 400, height: 20)
        stackView.anchors(top: chatroomStatus.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        messageTextView.anchors(top: stackView.topAnchor, leading: stackView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        sendButton.anchors(top: nil, leading:nil, bottom: nil, trailing: stackView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 0)
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
