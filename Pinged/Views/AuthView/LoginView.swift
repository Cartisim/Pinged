//
//  AuthView.swift
//  Pinged
//
//  Created by Cole M on 12/18/20.
//

import Cocoa

class LoginView: NSView {


    let stackView: NSStackView = {
        var stk = NSStackView()
        stk.orientation = .vertical
        stk.alignment = .bottom
        return stk
    }()
    
    let dismissButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.image = NSImage(named: "NSStopProgressTemplate")
        btn.contentTintColor = .white
        btn.font = .systemFont(ofSize: 16, weight: .regular)
        return btn
    }()
    
    let authTextField: NSTextField = {
        let txt = NSTextField.newLabel()
        txt.placeholderString = "Login into Pinged"
        txt.font = .systemFont(ofSize: 18, weight: .semibold)
        txt.textColor = .white
        return txt
    }()
    
    let emailTextField: NSTextField = {
        let txt = NSTextField()
        txt.placeholderString = "Your Email"
        return txt
    }()
    
    let passwordTextField: NSSecureTextField = {
        let txt = NSSecureTextField()
        txt.placeholderString = "Your Password"
        return txt
    }()
    
    let loginButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.title = "Login"
        btn.contentTintColor = .white
        btn.font = .systemFont(ofSize: 16, weight: .regular)
        return btn
    }()
    
    let regButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.title = "Create an Account"
        btn.contentTintColor = .white
        btn.font = .systemFont(ofSize: 16, weight: .regular)
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
        print("Memory Reclaimed in AuthView")
    }
    
    
    fileprivate func buildScroll() {
        wantsLayer = true
        addSubview(dismissButton)
        addSubview(authTextField)
        addSubview(stackView)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.orientation = .vertical
        stackView.alignment = .centerX
        addSubview(regButton)
    }
    
    fileprivate func anchors() {
        dismissButton.anchors(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        authTextField.anchors(top: dismissButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 12, paddingLeft: 20, paddingBottom: 5, paddingRight: 20, width: 0, height: 0)
        stackView.anchors(top: authTextField.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 5, paddingRight: 20, width: 250, height: 200)
        regButton.anchors(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
    }
}
