//
//  ChatViewItem.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatViewItem: NSCollectionViewItem {

    
     var chatItem: ChatItemView?
     
     override func viewDidLoad() {
         super.viewDidLoad()
     }
     
     override func loadView() {
        chatItem = ChatItemView()
         view = chatItem!
     }
     
         override var highlightState: NSCollectionViewItem.HighlightState {
             didSet {
//                 updateSelectionHighlighting()
             }
         }
     
     override var isSelected: Bool {
         didSet {
//             updateSelectionHighlighting()
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
