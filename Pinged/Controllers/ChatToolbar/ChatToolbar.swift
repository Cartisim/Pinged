//
//  ChatToolbar.swift
//  Cartisim
//
//  Created by Cole M on 10/24/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa


class ChatToolbar: NSToolbar, NSToolbarDelegate, NSToolbarItemValidation, NSSearchFieldDelegate {
    
    let searchView = NSView()
    let searchBar = NSSearchField()
    let contactButtonView = NSView()
    let contactButton = NSButton()
    let settingsButtonView = NSView()
    let settingsButton = NSButton()
    
     override init(identifier: NSToolbar.Identifier) {
        super.init(identifier: identifier)
        delegate = self
        searchBar.delegate = self
        searchBar.target = self
        searchBar.action = #selector(textDidChange(_:))
        anchors()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func anchors() {
        contactButtonView.addSubview(contactButton)
        settingsButtonView.addSubview(settingsButton)
        searchView.addSubview(searchBar)
        searchBar.placeholderString = "Search for a chat..."
        searchView.anchors(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 40)
        searchBar.anchors(top: searchView.topAnchor, leading: searchView.leadingAnchor, bottom: searchView.bottomAnchor, trailing: searchView.trailingAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        contactButtonView.anchors(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 24, height: 24)
        settingsButtonView.anchors(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        contactButton.anchors(top: contactButtonView.topAnchor, leading: contactButtonView.leadingAnchor, bottom: contactButtonView.bottomAnchor, trailing: contactButtonView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        settingsButton.anchors(top: settingsButtonView.topAnchor, leading: settingsButtonView.leadingAnchor, bottom: settingsButtonView.bottomAnchor, trailing: settingsButtonView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contactButton.image = NSImage(imageLiteralResourceName: "NSAdd")
        contactButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(chooseContact)))
        contactButton.isBordered = false
        
        settingsButton.image = NSImage(imageLiteralResourceName: "NSActionTemplate")
        settingsButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(settingsClicked)))
        settingsButton.isBordered = false
    }
    
    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        
        var toolbarItem = NSToolbarItem()
        switch itemIdentifier {
        case NSToolbarItem.Identifier.searchBar:
            toolbarItem = MyToolBarItem.shared.customToolbarItem(itemForItemIdentifier: NSToolbarItem.Identifier(rawValue: NSToolbarItem.Identifier.searchBar.rawValue), label: "", toolTip: "", selector: nil, itemContent: searchView)!
        case NSToolbarItem.Identifier.settingsButton:
            toolbarItem = MyToolBarItem.shared.customToolbarItem(itemForItemIdentifier: NSToolbarItem.Identifier(rawValue: NSToolbarItem.Identifier.settingsButton.rawValue), label: "label", toolTip: "User Settings", selector: nil, itemContent: settingsButtonView)!
        case NSToolbarItem.Identifier.contactsButton:
            toolbarItem = MyToolBarItem.shared.customToolbarItem(itemForItemIdentifier: NSToolbarItem.Identifier(rawValue: NSToolbarItem.Identifier.contactsButton.rawValue), label: "label", toolTip: "Choose a contact to chat with", selector: nil, itemContent: contactButtonView)!
            
        default:
            break
        }
        return toolbarItem
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier.contactsButton,
            NSToolbarItem.Identifier.settingsButton,
            NSToolbarItem.Identifier.flexibleSpace,
            NSToolbarItem.Identifier.searchBar
        ]
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.contactsButton, .settingsButton, .flexibleSpace, .searchBar
        ]
    }
    
    func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        return true
    }

    @objc func textDidChange(_ notification: NSSearchField) {
        let seachFieldDataDict:[String: String] = ["searchQuery": notification.stringValue]
        NotificationCenter.default.post(name: .queryChat, object: nil, userInfo: seachFieldDataDict)
    }
    
    @objc func checkAuthenticity() {
        
    }
    
    @objc func chooseContact() {
        let popover = NSPopover()
        let vc = ContactViewController()
        popover.contentViewController = vc
        popover.behavior = .transient
        popover.show(relativeTo: contactButtonView.bounds, of: contactButtonView, preferredEdge: .minY)
    }
    
    @objc func settingsClicked() {
        let popover = NSPopover()
        let vc = SettingsViewController()
        popover.contentViewController = vc
        popover.behavior = .transient
        popover.show(relativeTo: settingsButtonView.bounds, of: settingsButtonView, preferredEdge: .minY)
    }
}

