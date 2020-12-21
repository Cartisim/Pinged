//
//  ChatWindowController.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatWindowController: NSWindowController, NSWindowDelegate {

    let chatToolbar = ChatToolbar(identifier: .init(NSToolbar.chatWindowToolbar))
    
    convenience init() {
        self.init(windowNibName: "ChatWindowController")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.center()
        setUpWindow()
        window?.contentViewController = ChatSplitViewController()
    }
    
    fileprivate func setUpWindow() {
        window?.styleMask.insert(.fullSizeContentView)
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.backgroundColor = NSColor(cgColor: Constants.DARK_CHARCOAL_COLOR)
        window?.delegate = self
        window?.toolbar = chatToolbar
        window?.toolbar?.validateVisibleItems()
        chatToolbar.showsBaselineSeparator = false
        chatToolbar.allowsUserCustomization = true
        chatToolbar.autosavesConfiguration = true
    }
}
