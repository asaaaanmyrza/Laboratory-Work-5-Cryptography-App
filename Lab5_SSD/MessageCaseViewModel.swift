//
//  MessageCaseViewModel.swift
//  Lab5_SSD
//
//  Created by Асан Мырзахметов on 08.10.2026.
//

import SwiftUI
import Combine
import CryptoKit

final class MessageCaseViewModel: ObservableObject {
    @Published var messageInput: String = ""
    @Published var encryptedMessages: [AES.GCM.SealedBox] = []
    @Published var messages: [String] = ["Test"]
    
    private var key = 0
    private var cryptoService: EncryptService
    
    init() {
        self.cryptoService = EncryptService.shared
    }
    
    func decryptMessages() throws {
        messages = try encryptedMessages.map{ try cryptoService.decryptMessage(sealedMessage:$0)}
    }
    
    func sendMessage() throws {
        let encryptedMessage = try cryptoService.encryptMessage(message: messageInput)
        encryptedMessages.append(encryptedMessage)
        
        print(cryptoService.sealedBoxToString(box: encryptedMessage)!)
        
        messageInput = ""
    }
}
