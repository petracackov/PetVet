//
//  PetDetailsView.swift
//  PetVet
//
//  Created by Petra Cackov on 02/05/2022.
//

import SwiftUI

struct PetDetailsView: View {

    var pet: Pet

    init(pet: Pet) {
        self.pet = pet
    }

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 40) {
                    Rectangle()
                        .frame(width: proxy.size.width, height: proxy.size.width, alignment: .center)
                        .foregroundColor(.red)
                    HStack {
                        Spacer()
                        emojiView(icon: pet.typeUi.emoji, text: pet.typeUi.string)
                        Spacer()
                        emojiView(icon: pet.genderUi.emoji, text: pet.genderUi.string)
                        Spacer()
                    }

                    if let transponderCode = pet.transponderCode {
                        transponderCodeView(transponderCode)
                    }
                }
                .padding([.top, .bottom], 60)


            }
        }
    }

    func emojiView(icon: String, text: String) -> some View {
        VStack {
            EmojiView(emoji: icon)
            Text(text.uppercased())
                .font(Font.ui.subtitle)
                .foregroundColor(.ui.gray)
        }
    }

    func transponderCodeView(_ code: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            if let location = pet.transponderLocation {
                Text("Transponder code (\(location.lowercased())):")
                    .titleStyle()
            } else {
                Text("Transponder code:")
                    .titleStyle()
            }

            BarcodeView(barcode: code)
                .frame(height: 130)
                .border(Color.ui.borderGray, width: 2)

            Text(code)
                .frame(maxWidth: .infinity)
                .font(.ui.subtitle)
                .foregroundColor(.ui.gray)

        }
        .padding([.leading, .trailing])
    }
}

struct PetDetailsView_Previews: PreviewProvider {
    static private let pet = Pet(name: "teat", ownerId: "dfg", gender: .female, dateOfBirth: Date(), type: .cat, transponderCode: "12345678")
    static var previews: some View {
        PetDetailsView(pet: pet)
    }
}
