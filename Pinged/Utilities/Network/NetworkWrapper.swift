//
//  NetworkWrapper.swift
//  Cartisim
//
//  Created by Cole M on 6/8/20.
//  Copyright © 2020 Cole M. All rights reserved.
//

import Cocoa

class NetworkWrapper: NSObject {
    
    static let shared = NetworkWrapper()
    
    func codableNetworkWrapper<T: Codable>(refreshNetworkKey: String? = "", urlString: String, httpMethod: String, httpBody: Data?, headerField: String?, headerValue: String?, completion: @escaping (Result<T, Error>) -> ()) {
        if NetworkMonitor.shared.networkStatus() == false {
            print(NetworkCheck.noConnection)
            NSAlert().configuredAlert(title: NetworkCheck.checkNetwork.rawValue, text: NetworkCheck.checkNetwork.rawValue)
            UserDefaults.standard.set(NetworkCheck.checkNetwork.rawValue, forKey: Constants.AUTH_ERROR)
        } else if NetworkMonitor.shared.networkStatus() == true {
            UserDefaults.standard.set(refreshNetworkKey, forKey: Constants.REFRESH_NETWORK_KEY)
            guard let url = URL(string: urlString) else {return}
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.httpBody = httpBody
            request.addValue(HeaderValues.applicationJson.rawValue, forHTTPHeaderField: HeaderFields.contentType.rawValue)
            guard let hv = headerValue else {return}
            guard let hf = headerField else {return}
            request.addValue(hv, forHTTPHeaderField: hf)
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let strongSelf = self else {return}
                if let error = error {
                    UserDefaults.standard.set(error.localizedDescription, forKey: Constants.AUTH_ERROR)
                    completion(.failure(error))
                    print(error)
                }
                
                guard let response = response as? HTTPURLResponse else {return}
                print(response)
                if response.statusCode == 401 {
                    strongSelf.refreshAccessToken()
                } else {
                    do {
                        guard let responseData = data else { return }
                        let objects = try JSONDecoder().decode(T.self, from: responseData)
                        completion(.success(objects))
                    } catch let error {
                        UserDefaults.standard.set(error.localizedDescription, forKey: Constants.AUTH_ERROR)
                        completion(.failure(error))
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    /*Refresh Token is empty when we use UserData.shared.refreshToken. So We will just decrypt it agian from Keychain*/
    func refreshAccessToken() {
        let key = Crypto.shared.userInfoKey( Constants.KEYCHAIN_ENCRYPTION_KEY)
        do {
            let decryptToken = try Crypto.shared.decryptStringToCodableObject(Auth.self, from: KeychainItem.userObject, usingKey: key)
            guard let refresh = decryptToken.refreshToken else {return}
            let token = RefreshTokens.RefreshTokenViewModel(refreshToken: RefreshToken(refreshToken: refresh))
            NetworkWrapper.shared.refreshToken(refreshToken: token) { [weak self] (res) in
                guard let strongSelf = self else {return}
                switch res {
                case .success(let payload):
                    guard let user = payload.user else {return}
                    let userObjectString = try! Crypto.shared.encryptCodableObject(Auth(accessToken: payload.accessToken, refreshToken: payload.refreshToken, userID: user.id?.uuidString, username: user.fullName), usingKey: key)
                    KeychainItem.saveUserObject(object: userObjectString)
                    UserData.shared.accessToken = payload.accessToken
                    UserData.shared.refreshToken = payload.refreshToken
                    strongSelf.refreshNetwork()
                case .failure(let error):
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .logout, object: nil)
                        NSAlert().configuredAlert(title: "ERROR", text: "There was an error refreshing your auth status beacause your refresh token expired, please login again")
                    }
                    print(error)
                }
            }
        } catch {
            print("There was an error decrypting auth items")
        }
    }
    
    fileprivate func refreshToken(refreshToken: RefreshTokens.RefreshTokenViewModel, completion: @escaping (Result<PasswordToken, Error>) -> ()) {
        if NetworkMonitor.shared.networkStatus() == false {
            print(NetworkCheck.noConnection)
            UserDefaults.standard.set(NetworkCheck.checkNetwork.rawValue, forKey: Constants.AUTH_ERROR)
        } else if NetworkMonitor.shared.networkStatus() == true {
            guard let url = URL(string: Constants.REFRESH_TOKEN_URL) else {return}
            let body = try? JSONEncoder().encode(refreshToken.requestRefreshTokenObject())
            var request = URLRequest(url: url)
            request.httpMethod = Network.post.rawValue
            request.httpBody = body
            request.addValue(HeaderValues.applicationJson.rawValue, forHTTPHeaderField: HeaderFields.contentType.rawValue)
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let _ = self else {return}
                if let error = error {
                    completion(.failure(error))
                    print(error)
                }
                do {
                    guard let responseData = data else { return }
                    let objects = try JSONDecoder().decode(PasswordToken.self, from: responseData)
                    completion(.success(objects))
                } catch let error {
                    print(error)
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    
    fileprivate func refreshNetwork() {
        guard let refreshNetworkKey = UserDefaults.standard.string(forKey: Constants.REFRESH_NETWORK_KEY) else {return}
        RefreshNetwork().refreshNetworkTriggered(key: refreshNetworkKey)
    }
    
    func passFailNetworkWrapper(refreshNetworkKey: String? = "", urlString: String, httpMethod: String, httpBody: Data?, headerField: String? = HeaderFields.contentType.rawValue, headerValue: String? = HeaderValues.applicationJson.rawValue, completion: @escaping (PassFailResult<String>) -> Void) {
        if NetworkMonitor.shared.networkStatus() == false {
            print(NetworkCheck.noConnection)
            completion(.failure(NetworkCheck.checkNetwork.rawValue))
            UserDefaults.standard.set(NetworkCheck.checkNetwork.rawValue, forKey: Constants.AUTH_ERROR)
        } else if NetworkMonitor.shared.networkStatus() == true {
            UserDefaults.standard.set(refreshNetworkKey, forKey: Constants.REFRESH_NETWORK_KEY)
            guard let url = URL(string: urlString) else {return}
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.httpBody = httpBody
            request.addValue(HeaderValues.applicationJson.rawValue, forHTTPHeaderField: HeaderFields.contentType.rawValue)
            guard let hv = headerValue else {return}
            guard let hf = headerField else {return}
            request.addValue(hv, forHTTPHeaderField: hf)
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let strongSelf = self else {return}
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode, "RESPONSE STATUS CODE")
                    switch response.statusCode {
                    case 200...299: return completion(.success)
                    case 401: return strongSelf.refreshAccessToken()
                    case 402...500: return completion(.failure(NetworkResponse.authenticationError.rawValue))
                    case 501...599: return completion(.failure(NetworkResponse.badRequest.rawValue))
                    case 600: return completion(.failure(NetworkResponse.outdated.rawValue))
                    default: return completion(.failure(NetworkResponse.failed.rawValue))
                    }
                }
            }.resume()
        }
    }
}
