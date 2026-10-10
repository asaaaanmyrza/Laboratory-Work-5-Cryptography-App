//
//  PasswordCaseView.swift
//  Lab5_SSD
//
//  Created by Асан Мырзахметов on 08.10.2026.
//

import SwiftUI

struct PasswordCaseView: View {
    @StateObject var viewModel = PasswordCaseViewModel()
    var body: some View {
        Form {
            TextField("Username", text: $viewModel.inputLogin)
            TextField("Password", text: $viewModel.inputPassword)
            Button("Register") {
                viewModel.register()
            }
        }
        Form {
            TextField("Username", text: $viewModel.inputLogin)
            TextField("Password", text: $viewModel.inputPassword)
            Button("Login") {
                viewModel.login()
            }
            
            Text(viewModel.youAreLoggedIn)
        }
    }
}

#Preview {
    PasswordCaseView()
}
