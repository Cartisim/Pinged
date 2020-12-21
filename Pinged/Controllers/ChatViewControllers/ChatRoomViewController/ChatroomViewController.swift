//
//  ChatroomViewController.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa
import CryptoKit

class ChatroomViewController: NSViewController, SocketConnectionDelegate {
    
    var dataSource: NSCollectionViewDiffableDataSource<ChatroomSections, AnyHashable>!
    var chatrooms = Chatrooms()
    var isConnected = false
    var socketConnection: SocketConnection?
    
    
    init() {
        super.init(nibName: "", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        print("Reclaiming memory in ChatroomViewController")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView() {
        view = ChatroomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(startObserving), name: .startObservingChatroom, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearData), name: .clearChatroomData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchChatMessages), name: .refreshFetchChatMessages, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearData), name: .removeContacts, object: nil)
        let chatroomView = self.view as! ChatroomView
        chatroomView.collectionView.delegate = self
        chatroomView.collectionView.isSelectable = true
    }
    
    override func viewWillAppear() {
        configureHierarchy()
        configureDataSource()
        gestures()
    }
    
    override func viewWillDisappear() {
        socketConnection?.stopConnection()
        let chatroomView = self.view as! ChatroomView
        chatroomView.chatroomStatus.stringValue = ""
    }
    
    fileprivate func gestures() {
        let chatroomView = self.view as! ChatroomView
        chatroomView.sendButton.addGestureRecognizer(NSClickGestureRecognizer(target: self, action: #selector(saveMessageClicked)))
    }
    
    @objc func clearData() {
        DispatchQueue.main.async {
            if self.isConnected {
                self.chatrooms.chatroomViewModel.removeAll()
                var snapshot = NSDiffableDataSourceSnapshot<ChatroomSections, AnyHashable>()
                snapshot.deleteAllItems()
                self.dataSource.apply(snapshot)
            }

        }
    }
}
