//
//  AppButton.swift
//  MyPet
//
//  Created by Petra Cackov on 13. 7. 24.
//

import SwiftUI

struct AppButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.appOrangeLight, .appOrange], startPoint: .top, endPoint: .bottom)
            Text(title)
                .foregroundStyle(.appWhite)
                .font(.title3.bold())
                
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .clipShape(.capsule)
        .asButton {
            action()
        }
    }
}

#Preview {
    AppButton(title: "Title") { }
}
