//
//  MessageCaseView.swift
//  Lab5_SSD
//
//  Created by Асан Мырзахметов on 08.10.2026.
//

import SwiftUI

struct MessageCaseView: View {
    @StateObject private var viewModel = MessageCaseViewModel()
    var body: some View {
        Text("Message Case")
        ScrollView {
            ForEach(viewModel.messages, id: \.self) { message in
                    Text(message)
            }
        }
        HStack {
            TextField("Message", text: $viewModel.messageInput)
            Button("Send") {
                try! viewModel.sendMessage()
                try! viewModel.decryptMessages()
            }
        }
    }
}

#Preview {
    MessageCaseView()
}
