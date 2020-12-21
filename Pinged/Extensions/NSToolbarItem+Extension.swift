//
//  NSToolbarItem+Extension.swift
//  Cartisim
//
//  Created by Cole M on 10/24/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension NSToolbarItem.Identifier {
    static let searchBar = NSToolbarItem.Identifier( Constants.SEARCH_BAR)
    static let settingsButton = NSToolbarItem.Identifier( Constants.SETTINGS_BUTTON)
    static let contactsButton = NSToolbarItem.Identifier( Constants.CONTACTS_BUTTON)
}

final class MyToolBarItem: NSToolbarItem {
    static let shared = MyToolBarItem()
    
    func customToolbarItem(
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        label: String,
        toolTip: String,
        selector: Selector?,
        itemContent: AnyObject?) -> NSToolbarItem? {
        
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.target = self
        toolbarItem.action = selector
        toolbarItem.label = label
        toolbarItem.toolTip = toolTip
        toolbarItem.isBordered = false

        if itemContent is NSImage {
            if let image = itemContent as? NSImage {
                toolbarItem.image = image
            }
        } else if itemContent is NSView {
            if let view = itemContent as? NSView {
                toolbarItem.view = view
            }
        } else {
            assertionFailure("Invalid itemContent: object")
        }
        return toolbarItem
    }
}
