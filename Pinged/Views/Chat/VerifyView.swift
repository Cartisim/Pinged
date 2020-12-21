//
//  VerifyView.swift
//  Pinged
//
//  Created by Cole M on 12/19/20.
//

import Cocoa

class VerifyView: NSView {

    var stackView: NSStackView = {
        var stk = NSStackView()
        stk.orientation = .vertical
//        stk.alignment = .bottom
        return stk
    }()
    
    let verifyLabel: NSTextField = {
        let txt = NSTextField.newLabel()
        txt.textColor = .white
        txt.font = .systemFont(ofSize: 17, weight: .semibold)
        return txt
    }()
    
    
    var qrView: NSImageView = {
        let v = NSImageView()
        return v
    }()
    
    var codeImage: CIImage!
    
    var codeLabel: NSTextField = {
        let txt = NSTextField.newWrappingLabel()
        return txt
    }()
    
    let instructionLabel: NSTextField = {
        let txt = NSTextField.newWrappingLabel()
        txt.alignment = .center
        txt.stringValue = "To verify scan the code or check the persons numbers that you want to chat with match the numbers above"
        return txt
    }()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here
    }
    
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
        print("Memory Reclaimed in VerifyView")
    }
    
    
    fileprivate func buildScroll() {
        addSubview(stackView)
        stackView.addArrangedSubview(verifyLabel)
        stackView.addArrangedSubview(qrView)
        stackView.addArrangedSubview(codeLabel)
        stackView.addArrangedSubview(instructionLabel)
    }
    
    fileprivate func anchors() {
        anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 500)
        stackView.anchors(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        
    }
}
