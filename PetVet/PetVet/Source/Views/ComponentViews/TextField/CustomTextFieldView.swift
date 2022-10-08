//
//  CustomTextView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    var title: String = ""
    @Binding var text: String
    @FocusState var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                .titleStyle()
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .foregroundColor(.petVet(.blackWhite))
                .font(.ui.subtitle)
                .focused($isFocused)
                .rounded(borderColor: .petVet(.gray3))
        }
    }
}

struct CustomTextFieldView_Previews: PreviewProvider {
    @State static var text: String = "Hello"
    static var previews: some View {
        CustomTextFieldView(title: "hello", text: $text)
    }
}
