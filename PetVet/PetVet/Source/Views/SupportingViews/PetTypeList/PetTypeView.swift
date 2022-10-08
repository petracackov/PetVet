//
//  PetTypeView.swift
//  PetVet
//
//  Created by Petra Cackov on 24/04/2022.
//

import SwiftUI

struct PetTypeView: View {

    var pet: Pet.PetType
    var isSelected: Bool
    var onSelection: ((Pet.PetType) -> Void)?

    var body: some View {
        Button {
            withAnimation {
                onSelection?(pet)
            }
        } label: {
            VStack {
                EmojiView(emoji: pet.emoji, border: isSelected ? .petVet(.gray2) : .clear)
                if isSelected {
                    Text(pet.string)
                        .font(Font.ui.description)
                        .foregroundColor(.ui.gray)
                }
            }

        }
    }
}

struct PetTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PetTypeView(pet: Pet.PetType.cat, isSelected: true)
    }
}
