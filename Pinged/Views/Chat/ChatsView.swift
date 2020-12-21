//
//  ChatsView.swift
//  Cartisim
//
//  Created by Cole M on 12/7/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatsView: NSView {

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
        layer?.backgroundColor = .black
        scrollView = MyScrollView(frame: frame)
        addSubview(scrollView)
        scrollView.documentView = collectionView
        addSubview(stackView)
    }
    
    fileprivate func anchors() {
        scrollView.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 48, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        scrollView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 550).isActive = true
    }
}
