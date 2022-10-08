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
    var borderColor: Color = .clear
    var buttonAction: (() -> Void)?

    var body: some View {
        RoundedButton(
            title: title,
            backgroundColors: Appearance.Gradient.orange.colors,
            titleColor: titleColor,
            borderColor: borderColor,
            buttonAction: buttonAction)
        
        .frame(width: .infinity, height: 55)
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(title: "Button Title")
    }
}
