//
//  ChatroomItemPopoverViewController.swift
//  Cartisim
//
//  Created by Cole M on 12/10/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class ChatroomItemPopoverViewController: NSViewController {
    var object: Chatrooms.ChatroomViewModel?
    var snapshot = NSDiffableDataSourceSnapshot<ChatroomSections, AnyHashable>()
    var dataSource: NSCollectionViewDiffableDataSource<ChatroomSections, AnyHashable>!
    
    init(object: Chatrooms.ChatroomViewModel, snapshot: NSDiffableDataSourceSnapshot<ChatroomSections, AnyHashable>, datasource: NSCollectionViewDiffableDataSource<ChatroomSections, AnyHashable>!) {
        self.object = object
        self.snapshot = snapshot
        self.dataSource = datasource
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView() {
        view = ChatroomItemPopoverView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let popoverView = view.self as? ChatroomItemPopoverView
        popoverView?.deleteButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(deleteMessageClicked)))
    }
    
    @objc fileprivate func deleteMessageClicked() {
        let alert = NSAlert()
        alert.configuredCustomButtonAlert(title: "Delete Message", text: "Are you sure you want to delete this message? This is not a soft delete it will be gone forever!", firstButtonTitle: "Cancel", secondButtonTitle: "Delete", switchRun: true)
        let run = alert.runModal()
        switch run {
        case .alertFirstButtonReturn:
            print("Cancel")
        case .alertSecondButtonReturn:
            print("we delete")
            deleteConfirmed()
        default:
            break
        }
    }
    
    fileprivate func deleteConfirmed() {
        NetworkUtility.shared.deleteChatMessage { (res) in
            print(res, "RESPONSE")
            switch res {
            case .success:
                DispatchQueue.main.async {
                    if let message = self.object {
                        print(message, "Message")
                        self.snapshot.deleteItems([message])
                        self.dataSource.apply(self.snapshot)
                        
                    }
                }
            case .failure(let error):
                print(error, "Error")
                NSAlert().configuredAlert(title: "Error", text: "Sorry about the error, \(error)")
            }
        }
    }
}
