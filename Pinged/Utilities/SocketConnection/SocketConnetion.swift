//
//  SocketConnetion.swift
//  Cartisim
//
//  Created by Cole M on 11/29/20.
//  Copyright © 2020 Cole M. All rights reserved.
//


import Foundation
import Network
import os

protocol SocketConnectionDelegate: AnyObject {
    func didEstablishConnection(connection: SocketConnection, error: Error?)
    func didReceivedData(messageData: Data, connection: SocketConnection)
}


class SocketConnection {
    
    // MARK: - Private Variables
    
    private var socketConnection: NWConnection?
    private var nameForLogging: String = ""
    
    // MARK: - Public Variables
    weak var delegate: SocketConnectionDelegate?
    
    
    func createTLSParameters(allowInsecure: Bool, queue: DispatchQueue) -> NWParameters {
        let options = NWProtocolTLS.Options()
        let tcpOption = NWProtocolTCP.Options()
        sec_protocol_options_set_verify_block(options.securityProtocolOptions, { (sec_protocol_metadata, sec_trust, sec_protocol_verify_complete) in
            let trust = sec_trust_copy_ref(sec_trust).takeRetainedValue()
            var error: CFError?
            if SecTrustEvaluateWithError(trust, &error) {
                sec_protocol_verify_complete(true)
            } else {
                if allowInsecure == true {
                    sec_protocol_verify_complete(true)
                } else {
                    sec_protocol_verify_complete(false)
                }
            }
        }, queue)
        #if LOCAL || DEBUG
        return NWParameters(tls: .none, tcp: tcpOption)
        #else
        return NWParameters(tls: options, tcp: tcpOption)
        #endif
    }
    
    let workQueue = DispatchQueue(label: "chatSecureDispatch")
    // Thus us a new connection being initialized from the browsing device after the service was discovered.
    init(host: String, port: String, context: String) {
        #if LOCAL || DEBUG
        let params = createTLSParameters(allowInsecure: true, queue: self.workQueue)
        #else
        let params =  createTLSParameters(allowInsecure: false, queue: self.workQueue)
        #endif
        params.includePeerToPeer = true
        
        guard let unwrappedPort = NWEndpoint.Port(port) else { return }
        
        let nwEndpoint = NWEndpoint.hostPort(host: NWEndpoint.Host(host),
                                             port: unwrappedPort)
        
        socketConnection = NWConnection(to: nwEndpoint, using: params)
        nameForLogging = context
    }
    
    
    // MARK: - SocketConnection Instance Methods
    
    /**
     * @function startConnection
     * @discussion Starts connection and listens for the response to take the next action, i.e., setup a receive handler on .ready.
     */
    func startConnection(data: Data) {
        
        // Receive state updates for the connection and perform actions upon the ready and failed state.
        socketConnection?.stateUpdateHandler = { newState in
            
            switch newState {
            case .ready:
                os_log("%{public}@ - Connection established", self.nameForLogging)
                self.delegate?.didEstablishConnection(connection: self, error: nil)
                self.sendDataOnConnection(data: data)
                self.receiveIncomingDataOnConnection()
            case .preparing:
                os_log("%{public}@ - Connection preparing", self.nameForLogging)
            case .setup:
                os_log("%{public}@ - Connection setup", self.nameForLogging)
            case .waiting(let error):
                os_log("%{public}@ - Connection waiting: %{public}@", self.nameForLogging, error.localizedDescription)
            case .failed(let error):
                os_log("%{public}@ - Connection failed: %{public}@", self.nameForLogging, error.localizedDescription)
                
                // Cancel the connection upon a failure.
                self.socketConnection?.cancel()
                
                // Notify your delegate that the connection failed with an error message.
                self.delegate?.didEstablishConnection(connection: self, error: error)
            default:
                break
            }
        }
        
        // Start the connection and send receive responses on the main queue.
        socketConnection?.start(queue: .main)
        
        // Setup the receive method to ensure data is captured on the incoming connection.
        self.receiveIncomingDataOnConnection()
    }
    
    func stopConnection() {
        socketConnection?.cancel()
        socketConnection?.restart()
    }
    
    /**
     * @function sendDataOnConnection
     * @discussion Send socket data on a connection as TCP bytes.
     */
    func sendDataOnConnection(data: Data) {
        
        os_log("%{public}@ - Sending: %{public}d bytes", nameForLogging, data.count)
        
        socketConnection?.send(content: data, completion: NWConnection.SendCompletion.contentProcessed { error in
            if let error = error {
                os_log("%{public}@ - Error sending data: %{public}@", self.nameForLogging, error.localizedDescription)
            }
        })
    }
    
    /**
     * @function receiveIncomingDataOnConnection
     * @discussion Receive data (content), including protocol metadata context (context),
     *           with an indication of the completion context (isComplete), with possible error (error).
     * @note           isComplete is not used in the callback because UDP will not deliver a partial message, We are using TCP.
     */

    let chatrooms = Chatrooms()
    func receiveIncomingDataOnConnection() {
        socketConnection?.receive(minimumIncompleteLength: 1, maximumLength: 437358, completion: { (content, context, isComplete, error) in
            if let messageData = content {
                os_log("%{public}@ - received: %{public}d bytes", self.nameForLogging, messageData.count)
                    self.delegate?.didReceivedData(messageData: messageData, connection: self)
            }
        })
    }
}

