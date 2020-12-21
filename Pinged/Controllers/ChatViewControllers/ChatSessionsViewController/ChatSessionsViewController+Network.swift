//
//  ChatsViewController+Network.swift
//  Cartisim
//
//  Created by Cole M on 12/7/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension ChatSessionsViewController {
    @objc func fetchUserChatSessions() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetworkUtility.shared.fetchUserChatSessions { [weak self] (res) in
            switch res {
            case .success(let user):
                guard let strongSelf = self else {return}
                strongSelf.userChatSessions.userChatSessionsViewModel.append(UserChatSessions.UserChatSessionsViewModel(user: user))
                strongSelf.chatSessions.chatSessionsViewModel.append(contentsOf: user.chatSession.map({ ChatSessions.ChatSessionsViewModel(chatSessions: $0) }))
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.performQuery(with: "")
        }
    }
    
    @objc func deleteChatSessionClicked() {
        NetworkUtility.shared.deleteChatSession { [weak self] (res) in
            guard let strongSelf = self else {return}
            switch res {
            case .success:
                print("Success")
                if let chat = strongSelf.chatSessions.chatSessionsViewModel.last {
                    var snap = strongSelf.dataSource.snapshot()
                    snap.deleteItems([chat])
                    strongSelf.dataSource.apply(snap)
                }
            case .failure(let error):
                print(error)
                NSAlert().configuredAlert(title: "Error", text: "Failed to Delete Chat Session: \(error)")
            }
        }
    }
    
    func performQuery(with string: String) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<ChatSessionsSections, AnyHashable>()
            let filter = self.chatSessions.searchChats(with: string).sorted { $0.createdAt! < $1.createdAt! }
            snapshot.appendSections([.chats])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            snapshot.appendItems(filter, toSection: .chats)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
