//
//  ChatSessionsViewController.swift
//  Cartisim
//
//  Created by Cole M on 12/7/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa
import CryptoKit

class ChatSessionsViewController: NSViewController, NSCollectionViewDelegate {
    
    var dataSource: NSCollectionViewDiffableDataSource<ChatSessionsSections, AnyHashable>!
    var object: ChatSessions.ChatSessionsViewModel?
    let userChatSessions = UserChatSessions()
    let chatSessions = ChatSessions()
    
    init() {
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ChatsView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchUserChatSessions), name: .refreshFetchUserChatSessions, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchUserChatSessions), name: .fetchChatSession, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.query), name: .queryChat, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeData), name: .removeChats, object: nil)
        let chatSessionView = self.view as! ChatsView
        chatSessionView.collectionView.delegate = self
        chatSessionView.collectionView.isSelectable = true
        collectionViewMenu()
    }
    
    override func viewWillAppear() {
        
        
    }
    
    override func viewDidAppear() {
        fetchUserChatSessions()
        configureHierarchy()
        configureDataSource()
    }
    
    fileprivate func collectionViewMenu() {
        let chatSessionView = self.view as! ChatsView
        let menu = NSMenu()
        menu.addItem(withTitle: "Verify Chat", action: #selector(verifyChatClicked), keyEquivalent: "V")
        menu.addItem(withTitle: "Delete Chat", action: #selector(deleteChatSessionClicked), keyEquivalent: "D")
        chatSessionView.collectionView.menu = menu
    }
    
    @objc func query(_ notification: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {return}
            if let dict = notification.userInfo as NSDictionary? {
                if let query = dict["searchQuery"] as? String {
                    strongSelf.performQuery(with: query)
                    print(query)
                }
            }
        }
    }
    
    @objc func verifyChatClicked() {
        let vc = VerifyViewController(publicKey: chatSessions.chatSessionsViewModel.last!.publicKey)
        presentAsSheet(vc)
    }
    
    @objc func removeData() {
        DispatchQueue.main.async {
            self.chatSessions.chatSessionsViewModel.removeAll()
            self.userChatSessions.userChatSessionsViewModel.removeAll()
            var snapshot = NSDiffableDataSourceSnapshot<ChatSessionsSections, AnyHashable>()
            snapshot.deleteAllItems()
            self.dataSource.apply(snapshot)
        }
    }
    
}
