//
//  ChatroomViewController+Network.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension ChatroomViewController {
    
    @objc func fetchChatMessages() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetworkUtility.shared.fetchChatMessages { [weak self] (res) in
            switch res {
            case .success(let messages):
                guard let strongSelf = self else {return}
                strongSelf.chatrooms.chatroomViewModel.append(contentsOf: messages.map{ Chatrooms.ChatroomViewModel(chatroom: $0 )})
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.createSnapshot()
            strongSelf.scrollToBottom()
        }
    }
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ChatroomSections, AnyHashable>()
        let filter = self.chatrooms.chatroomViewModel.sorted { $0.createdAt! < $1.createdAt! }
            snapshot.appendSections([.chatroom])
        self.dataSource.apply(snapshot, animatingDifferences: true)
            snapshot.appendItems(filter, toSection: .chatroom)
            self.dataSource.apply(snapshot, animatingDifferences: true)
    }

    func scrollToBottom() {
        let chatroomView = self.view as! ChatroomView
        chatroomView.collectionView.scrollToBottom(datasource: self.chatrooms.chatroomViewModel.count, duration: 6, implicit: true)
    }
    
}
