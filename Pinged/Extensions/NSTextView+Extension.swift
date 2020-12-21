//
//  NSTextView+Extension.swift
//  Cartisim
//
//  Created by Cole M on 10/11/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

final class MyTextView: NSTextView {
    var placeholderAttributedString: NSAttributedString?
}

extension NSTextView {
    func textViewDidBeginEditing(textView: MyTextView) {
        textView.layer?.borderColor = .white
    }
    
    func textViewDidEndEditing(textView: MyTextView) {
        textView.layer?.borderColor = .black
    }
}

final class ScrollableTextView: NSView {
    lazy var textStorage = NSTextStorage()
    lazy var layoutManager = NSLayoutManager()
    lazy var textContainer = NSTextContainer()
    lazy var scrollView = NSScrollView()
    lazy var textView: MyTextView = MyTextView(frame: CGRect(), textContainer: textContainer)
    lazy var leading = CGFloat()
    
    fileprivate func setupTextStack() {
        
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
    }
    
    fileprivate func setupUI(isHorizontalScrollingEnabled: Bool, leading: CGFloat? = 75, top: CGFloat? = 0, bottom: CGFloat? = 0, trailing: CGFloat? = 0, width: CGFloat? = 600, height: CGFloat? = 200) {
        
        let contentSize = scrollView.contentSize
        
        if isHorizontalScrollingEnabled {
            textContainer.containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            textContainer.widthTracksTextView = false
        } else {
            textContainer.containerSize = CGSize(width: contentSize.width, height: CGFloat.greatestFiniteMagnitude)
            textContainer.widthTracksTextView = true
        }
        
        textView.minSize = CGSize(width: 0, height: 0)
        textView.maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = isHorizontalScrollingEnabled
        textView.frame = CGRect(x: scrollView.frame.origin.x, y: scrollView.frame.origin.y, width: contentSize.width, height: contentSize.height)
        if isHorizontalScrollingEnabled {
            textView.autoresizingMask = [.width, .height]
        } else {
            textView.autoresizingMask = [.width]
        }
        textView.font = NSFont.systemFont(ofSize: 15)
        textView.wantsLayer = true
        textView.textColor = .white
        textView.alignment = .left
        
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = isHorizontalScrollingEnabled
        scrollView.documentView = textView
        scrollView.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        scrollView.drawsBackground = false
        textView.drawsBackground = false
        scrollView.backgroundColor = .clear
        textView.backgroundColor = .clear
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        addSubview(scrollView)
        setupUI(isHorizontalScrollingEnabled: false)
        setupTextStack()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError()
    }
}
