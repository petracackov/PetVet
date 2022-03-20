//
//  CustomTextView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    var title: String = "Title"
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .font(.ui.title)
                .foregroundColor(.ui.gray)
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .background(Color.ui.backgroundGray)
                .foregroundColor(.ui.gray)
                .font(.ui.subtitle)
                .clipShape(Capsule())
                .overlay(
                    Capsule(style: .circular)
                        .stroke(Color.ui.borderGray, style: StrokeStyle(lineWidth: 2))
                )
                .foregroundColor(Color.ui.gray)
        }
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        CustomTextFieldView(text: $text)
    }
}
