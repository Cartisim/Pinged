//
//  RegisterView.swift
//  Pinged
//
//  Created by Cole M on 12/18/20.
//

import Cocoa

class RegisterView: NSView {


    let stackView: NSStackView = {
        var stk = NSStackView()
        stk.orientation = .vertical
        stk.alignment = .bottom
        return stk
    }()
    
    let progressIndicator: NSProgressIndicator = {
        let ind = NSProgressIndicator()
        return ind
    }()
    
    let authTextField: NSTextField = {
        let txt = NSTextField.newLabel()
        txt.placeholderString = "Register a Pinged account"
        txt.font = .systemFont(ofSize: 18, weight: .semibold)
        txt.textColor = .white
        return txt
    }()
    
    let nameTextField: NSTextField = {
        let txt = NSTextField()
        txt.placeholderString = "Your Name"
        return txt
    }()
    let emailTextField: NSTextField = {
        let txt = NSTextField()
        txt.placeholderString = "Your Email"
        return txt
    }()
    
    let passwordTextField: NSSecureTextField = {
        let txt = NSSecureTextField()
        txt.placeholderString = "Password"
        return txt
    }()
    let confirmPasswordTextField: NSSecureTextField = {
        let txt = NSSecureTextField()
        txt.placeholderString = "Confirm Password"
        return txt
    }()
    
    let dismissButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.image = NSImage(named: "NSGoBackTemplate")
        btn.contentTintColor = .white
        btn.font = .systemFont(ofSize: 16, weight: .regular)
        return btn
    }()
    
    let registerButton: NSButton = {
        let btn = NSButton()
        btn.isBordered = false
        btn.title = "Register"
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
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(registerButton)
        stackView.orientation = .vertical
        stackView.alignment = .centerX
        layer?.backgroundColor = Constants.DARK_CHARCOAL_COLOR
    }
    
    fileprivate func anchors() {
        dismissButton.anchors(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        authTextField.anchors(top: dismissButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 12, paddingLeft: 20, paddingBottom: 5, paddingRight: 20, width: 0, height: 0)
        stackView.anchors(top: authTextField.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 5, paddingRight: 20, width: 250, height: 200)
        registerButton.anchors(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
    }
}
