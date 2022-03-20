//
//  CustomButtonView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct CustomButtonView: View {
    var title: String = ""
    var backgroundColor: Color = .ui.orange
    var titleColor: Color = .ui.white
    var buttonAction: (() -> Void)?

    var body: some View {
        Button {
            buttonAction?()
        } label: {
            Text(title)
                .foregroundColor(titleColor)
                .font(.ui.title)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(Capsule())
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(title: "Button Title")
    }
}
