//
//  Network.swift
//  Cartisim
//
//  Created by Cole M on 8/27/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Foundation

enum Network: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum PassFailResult<String>{
    case success
    case failure(String)
}

enum PassFailImage<NSImage, String>{
    case success(NSImage)
    case failure(String)
}

enum NetworkCall: String {
    case currentUser = "currentUser"
    case user = "user"
    case users = "users"
    case deleteCurrentUser = "deleteCurrentUser"
    case fetchChatSessions = "fetchChatSessions"
    case fetchUserChatSessions = "fetchUserChatSessions"
    case fetchChatContacts = "fetchChatContacts"
    case postSenderKey = "postSenderKey"
    case fetchChatMessages = "fetchChatMessages"
    case siblingRelationship = "siblingRelationship"
    
}

enum NetworkCheck: String {
    case checkNetwork = "Please check your network connection."
    case noConnection = "No Connection"
}


enum HeaderFields: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
}

enum HeaderValues: String {
    case bearerAuth = "Bearer "
    case basicAuth = "Basic "
    case applicationJson = "application/json"
}
