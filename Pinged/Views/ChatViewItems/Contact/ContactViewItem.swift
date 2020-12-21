//
//  ContactViewItem.swift
//  Cartisim
//
//  Created by Cole M on 12/5/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ContactViewItem: NSCollectionViewItem {

    
     var contactItem: ContactItemView?
     
     override func viewDidLoad() {
         super.viewDidLoad()
     }
     
     override func loadView() {
        contactItem = ContactItemView()
         view = contactItem!
     }
     
         override var highlightState: NSCollectionViewItem.HighlightState {
             didSet {
                 updateSelectionHighlighting()
             }
         }
     
     override var isSelected: Bool {
         didSet {
             updateSelectionHighlighting()
         }
     }
     
         private func updateSelectionHighlighting() {
             if !isViewLoaded {
                 return
             }
     
             let showAsHighlighted = (highlightState == .forSelection) ||
                 (isSelected && highlightState != .forDeselection) ||
                 (highlightState == .asDropTarget)
     
             textField?.textColor = showAsHighlighted ? .selectedControlTextColor : .labelColor
             view.layer?.backgroundColor = showAsHighlighted ? NSColor.selectedControlColor.cgColor : nil
         }
}

