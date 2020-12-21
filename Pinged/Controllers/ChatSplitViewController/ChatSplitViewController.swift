//
//  ChatSplitViewController.swift
//  Cartisim
//
//  Created by Cole M on 12/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatSplitViewController: NSSplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if splitViewItems.isEmpty{
            let masterVC = ChatSessionsViewController()
            let secondDetailVC = ChatroomViewController()
            addSplitViewItem(NSSplitViewItem(viewController: masterVC))
            addSplitViewItem(NSSplitViewItem(viewController: secondDetailVC))
        }
    }
    
}
