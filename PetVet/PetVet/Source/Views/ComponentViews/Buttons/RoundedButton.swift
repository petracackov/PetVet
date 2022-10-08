//
//  RoundedButton.swift
//  PetVet
//
//  Created by Petra Cackov on 15/05/2022.
//

import SwiftUI

struct RoundedButton: View {
    var title: String = ""
    var backgroundColors: [Color] = Appearance.Gradient.orange.colors
    var titleColor: Color = .ui.white
    var borderColor: Color = .clear
    var buttonAction: (() -> Void)?

    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Text(title)
                .foregroundColor(titleColor)
                .font(.ui.titleBold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(colors: backgroundColors, startPoint: .top, endPoint: .bottom)
        )
        .rounded(borderColor: borderColor)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "Hello")
    }
}
