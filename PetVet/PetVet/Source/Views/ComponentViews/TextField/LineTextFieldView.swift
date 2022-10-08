//
//  LineTextFieldView.swift
//  PetVet
//
//  Created by Petra Cackov on 18/04/2022.
//

import SwiftUI

struct LineTextFieldView: View {

    @Binding var text: String

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            TextField("", text: $text)
                .textFieldStyle(.plain)
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                .foregroundColor(.petVet(.blackWhite))
                .font(.ui.title)
                .multilineTextAlignment(.center)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.petVet(.gray3))
        }
    }
}

struct LineTextFieldView_Previews: PreviewProvider {
    @State static var text: String = "Some text"
    static var previews: some View {
        LineTextFieldView(text: $text)
    }
}
