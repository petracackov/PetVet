//
//  CustomLineTextField.swift
//  PetVet
//
//  Created by Petra Cackov on 09/10/2022.
//

import SwiftUI

struct CustomLineTextField: View {

    var title: String?
    var textFieldIsDisabled = false
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title = title {
                Text(title)
                    .foregroundColor((.petVet(.blackWhite)))
                    .font(.ui.subtitle)
            }
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .foregroundColor(.petVet(.blackWhite))
                .font(.ui.title)
                .multilineTextAlignment(.leading)
                .disabled(textFieldIsDisabled)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.petVet(.gray3))
        }
    }
}

struct CustomLineTextField_Previews: PreviewProvider {
    @State static var text: String = "Some text"
    static var previews: some View {
        CustomLineTextField(title: "hello", text: $text)
    }
}
