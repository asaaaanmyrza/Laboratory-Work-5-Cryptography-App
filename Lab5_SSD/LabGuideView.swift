//
//  LabGuideView.swift
//  Lab5_SSD
//
//  Created by Асан Мырзахметов on 08.10.2026.
//

import SwiftUI

struct LabGuideView: View {
    var body: some View {
        Text("Hello, choose the Case:")
        
        HStack (spacing: 20) {
            NavigationLink("Message Case",destination: MessageCaseView())
                .frame(width: 200, height: 100)
                .border(.black)
            NavigationLink("Password Case",destination: PasswordCaseView())
                .frame(width: 200, height: 100)
                .border(.black)
        }
    }
}

#Preview {
    NavigationStack {
        LabGuideView()
    }
}
