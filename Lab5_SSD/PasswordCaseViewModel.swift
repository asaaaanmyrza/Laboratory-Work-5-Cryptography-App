//
//  PasswordCaseViewModel.swift
//  Lab5_SSD
//
//  Created by Асан Мырзахметов on 10.10.2026.
//

import Combine
import Foundation
import SwiftUI
import CryptoKit

final class PasswordCaseViewModel: ObservableObject {
    @Published var inputLogin: String = ""
    @Published var inputPassword: String = ""
    private var users: [String : SHA256.Digest] = [:]
    private var successfulLogin: Bool = false
    @Published var youAreLoggedIn: String = "You are not logged in"
    
    private let cryptoService: EncryptService
    
    init() {
        self.cryptoService = EncryptService.shared
    }
    
    func register() {
        if inputLogin == "" || inputPassword == "" { return }
        let username = inputLogin
        let password = inputPassword
        let encryptedPassword = cryptoService.passwordHashing(input: password)
        
        users[username] = encryptedPassword
        
        inputLogin = ""
        inputPassword = ""
        
        print("User, with username: \(username), and password: \(cryptoService.SHA256ToString(digest: encryptedPassword)), has successfully registered")
    }
    
    func login() {
        if inputLogin == "" || inputPassword == "" { return }
        let username = inputLogin
        let password = inputPassword
        let encryptedPassword = cryptoService.passwordHashing(input: password)
        
        let success = encryptedPassword == users[username]
        
        if success {
            successfulLogin = true
            youAreLoggedIn = "You have successfully logged in!"
            inputLogin = ""
            inputPassword = ""
            print("User, with username: \(username), and password: \(cryptoService.SHA256ToString(digest: encryptedPassword)), has successfully logged in")
            return
        }

        successfulLogin = false
        youAreLoggedIn = "You are not logged in"
        print("User, with username: \(username), and password: \(cryptoService.SHA256ToString(digest: encryptedPassword)), has not successfully logged in")
    }
}
