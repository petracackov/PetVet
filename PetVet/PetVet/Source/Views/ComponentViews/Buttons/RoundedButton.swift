//
//  RoundedButton.swift
//  PetVet
//
//  Created by Petra Cackov on 15/05/2022.
//

import SwiftUI

struct RoundedButton: View {
    var title: String = ""
    var backgroundColor: Color = .ui.orange
    var titleColor: Color = .ui.white
    var borderColor: Color = .clear
    var buttonAction: (() -> Void)?

    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Text(title)
                .foregroundColor(titleColor)
                .font(.ui.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .rounded(borderColor: borderColor)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "Hello")
    }
}
