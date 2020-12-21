//
//  NetworkUtility.swift
//  Cartisim
//
//  Created by Cole M on 6/9/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation


class NetworkUtility {
    
    static let shared = NetworkUtility()
    
    //MARK:-Authentication
    //POST
    func register(register: Registers.RegisterViewModel, completion: @escaping (PassFailResult<String>) -> Void) {
        let url = Constants.REGISTER_URL
        let body = try? JSONEncoder().encode(register.requestRegisterObject())
        NetworkWrapper.shared.passFailNetworkWrapper(urlString: url, httpMethod: Network.post.rawValue, httpBody: body, completion: completion)
        
    }
    
    func login(login: Logins.LoginViewModel, completion: @escaping(Result<PasswordToken, Error>) -> Void) {
        let url = Constants.LOGIN_URL
        guard let credentials = "\(login.email.lowercased()):\(login.password)".data(using: String.Encoding.utf8)?.base64EncodedString() else { return }
        let body = try? JSONEncoder().encode(login.requestLoginObject())
        NetworkWrapper.shared.codableNetworkWrapper(urlString: url, httpMethod: Network.post.rawValue, httpBody: body, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.basicAuth.rawValue + "\(credentials)", completion: completion)
    }
    
    func resendConfirmationEmail(email: VerificationEmails.VerificationEmailViewModel, completion: @escaping (PassFailResult<String>) -> Void) {
        let url = Constants.EMAIL_VERIFICATION_URL
        let body = try? JSONEncoder().encode(email.requestVerificationEmailObject())
        NetworkWrapper.shared.passFailNetworkWrapper(urlString: url, httpMethod: Network.post.rawValue, httpBody: body, completion: completion)
    }

    func deleteCurrentUser(completion: @escaping(PassFailResult<String>) -> Void) {
        let url = Constants.DELETE_CURRENT_USER_URL
        NetworkWrapper.shared.passFailNetworkWrapper(refreshNetworkKey: NetworkCall.deleteCurrentUser.rawValue, urlString: url, httpMethod: Network.delete.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue + UserData.shared.accessToken, completion: completion)
    }

    //Mark:- Chat
    func fetchChatSessions(completion: @escaping(Result<[ChatSession], Error>) -> Void) {
        let url = Constants.CHAT_SESSIONS_URL
        NetworkWrapper.shared.codableNetworkWrapper(refreshNetworkKey: NetworkCall.fetchChatSessions.rawValue, urlString: url, httpMethod: Network.get.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue, completion: completion)
    }
    
    func fetchUserChatSessions(completion: @escaping(Result<UserChatSession, Error>) -> Void) {
        let url = Constants.FETCH_USER_CHAT_SESSION + UserData.shared.userID
        NetworkWrapper.shared.codableNetworkWrapper(refreshNetworkKey: NetworkCall.fetchUserChatSessions.rawValue, urlString: url, httpMethod: Network.get.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue, completion: completion)
    }
    
    func fetchChatContacts(completion: @escaping(Result<[Contact], Error>) -> Void) {
        let url = Constants.CHAT_CONTACTS_URL
        NetworkWrapper.shared.codableNetworkWrapper(refreshNetworkKey: NetworkCall.fetchChatContacts.rawValue, urlString: url, httpMethod: Network.get.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue, completion: completion)
    }
    
    func postSenderKey(chatSession: ChatSessions.ChatSessionsViewModel, completion: @escaping(Result<ChatSession,Error>) -> Void) {
        let url = Constants.POST_SENDER_URL
        let body = try? JSONEncoder().encode(chatSession.requestChatSessionObject())
        NetworkWrapper.shared.codableNetworkWrapper(refreshNetworkKey: NetworkCall.postSenderKey.rawValue, urlString: url, httpMethod: Network.post.rawValue, httpBody: body, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue + UserData.shared.accessToken, completion: completion)
    }
    
    func addKeyToUser(key: E2EPublicKeys.E2EPublicKeyViewModel, completion: @escaping(PassFailResult<String>) -> Void) {
        let url = Constants.ADD_KEY_TO_USER_URL + UserData.shared.userID
        let body = try? JSONEncoder().encode(key.requestPublicKeyObject())
        NetworkWrapper.shared.passFailNetworkWrapper(urlString: url, httpMethod: Network.put.rawValue, httpBody: body, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue + UserData.shared.accessToken, completion: completion)
    }
    
    func deleteChatSession(completion: @escaping(PassFailResult<String>) -> Void) {
        let url = Constants.DELETE_CHAT_SESSION_URL + ChatSessionData.shared.chatSessionID
        NetworkWrapper.shared.passFailNetworkWrapper(urlString: url, httpMethod: Network.delete.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue + UserData.shared.accessToken, completion: completion)
    }
    
//    func fetchChatroomMessages
    func fetchChatMessages(completion: @escaping(Result<[Chatroom], Error>) -> Void) {
        let url = Constants.CHAT_MESSAGES_URL + ChatSessionData.shared.chatSessionID
        NetworkWrapper.shared.codableNetworkWrapper(refreshNetworkKey: NetworkCall.fetchChatMessages.rawValue, urlString: url, httpMethod: Network.get.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue + UserData.shared.accessToken, completion: completion)
    }
    
    func deleteChatMessage(completion: @escaping(PassFailResult<String>) -> Void) {
        let url = Constants.DELETE_CHAT_MESSAGE_URL + ChatroomData.shared.messageID
        NetworkWrapper.shared.passFailNetworkWrapper(urlString: url, httpMethod: Network.delete.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue + UserData.shared.accessToken, completion: completion)
    }

    
    //MARK:-Generic calls
    func siblingRelationship(leftSibling: String, leftID: String, rightSibling: String, rightID: String, completion: @escaping (PassFailResult<String>) -> Void) {
        let url = BASE_URL + leftSibling + "/" + leftID + "/" + rightSibling + "/" + rightID
        NetworkWrapper.shared.passFailNetworkWrapper(refreshNetworkKey: NetworkCall.siblingRelationship.rawValue, urlString: url, httpMethod: Network.post.rawValue, httpBody: nil, headerField: HeaderFields.authorization.rawValue, headerValue: HeaderValues.bearerAuth.rawValue + UserData.shared.accessToken, completion: completion)
    }
}
