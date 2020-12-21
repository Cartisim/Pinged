//
//  ChatroomViewController+Socket.swift
//  Cartisim
//
//  Created by Cole M on 12/12/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

extension ChatroomViewController {
    
    @objc func startObserving() {
            clearData()
        fetchChatMessages()
        socketConnection = SocketConnection(host: Constants.TCP_HOST, port: "8081", context: "SocketConnection")
        socketConnection?.delegate = self
        do {
            let data = try JSONEncoder().encode(SessionID(chatSessionID: ChatSessionData.shared.chatSessionID, token: UserData.shared.accessToken))
            socketConnection?.startConnection(data: data)
        } catch {
            print(error)
        }

    }
    
    @objc func saveMessageClicked() {
        let chatroomView = self.view as! ChatroomView
        if isConnected {
            do {
                let encryptMessage = try Crypto.shared.encryptText(text: chatroomView.messageTextView.textView.string, symmetricKey: ChatSessionData.shared.chatSymmetricKey)
                let encryptName = try Crypto.shared.encryptText(text: UserData.shared.username, symmetricKey: ChatSessionData.shared.chatSymmetricKey)
                let data = try JSONEncoder().encode(ChatroomRequest(avatar: "", contactID: UserData.shared.userID, fullName: encryptName, message: encryptMessage, token: UserData.shared.accessToken, sessionID: ChatSessionData.shared.chatSessionID, chatSessionID: ChatSessionData.shared.chatSessionID))
                socketConnection?.sendDataOnConnection(data: data)
                socketConnection?.receiveIncomingDataOnConnection()
                chatroomView.messageTextView.textView.string = ""
                
            } catch {
                print(error)
            }
            return
        }
    }
    
    func didEstablishConnection(connection: SocketConnection, error: Error?) {
        isConnected = true
        var snapshot = NSDiffableDataSourceSnapshot<ChatroomSections, AnyHashable>()
        snapshot.deleteAllItems()
        dataSource.apply(snapshot)
        chatrooms.chatroomViewModel.removeAll()
        print("TCP connection established, send data.")
        let chatroomView = self.view as! ChatroomView
        chatroomView.chatroomStatus.stringValue = "This Chat is using End-to-End Encryption and is encrypted with TLS"
        chatroomView.watermark.isHidden = true
    }
    
    func didReceivedData(messageData: Data, connection: SocketConnection) {
        do {
            let message = try JSONDecoder().decode(Chatroom.self, from: messageData)
            let decryptedName = Crypto.shared.decryptText(text: message.fullName, symmetricKey: ChatSessionData.shared.chatSymmetricKey)
            let decryptedMessage = Crypto.shared.decryptText(text: message.message, symmetricKey: ChatSessionData.shared.chatSymmetricKey)
            LocalNotification.newMessageNotification(title: "New Message!", subtitle: decryptedName, body: decryptedMessage)
            self.chatrooms.chatroomViewModel.append(Chatrooms.ChatroomViewModel(chatroom: message))
            DispatchQueue.main.async {
                self.createSnapshot()
            }
        } catch {
            print(error)
        }
    }
}
