//
//  ItemView.swift
//  PetVet
//
//  Created by Petra Cackov on 26/03/2022.
//

import SwiftUI

struct ItemView: View {

    var item: MenuVM.ListItems
    var isSelected: Bool
    var onSelection: ((MenuVM.ListItems) -> Void)?

    var body: some View {
        Button {
            onSelection?(item)
        } label: {
            circle(item: item)
        }
    }
    func circle(item: MenuVM.ListItems) -> some View {
        switch item {
        case .user: return AnyView(EmojiView(emoji: "🙂", border: isSelected ? .ui.white : .clear))
        case .pet(let pet): return AnyView(EmojiView(emoji: pet.typeUi.emoji, border: isSelected ? .ui.white : .clear))
        case .addNew: return AnyView(addNewView())
        case .loading: return AnyView(ProgressView())
        }
    }

    func addNewView() -> some View {
        return ZStack {
            Rectangle()
                .frame(width: 30, height: 3, alignment: .center)
                .foregroundColor(Color.ui.gray)
            Rectangle()
                .frame(width: 3, height: 30, alignment: .center)
                .foregroundColor(Color.ui.gray)
            Circle()
                .strokeBorder(Color.ui.gray, lineWidth: 3)
                .frame(width: 60, height: 60, alignment: .center)
        }

    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: .user, isSelected: false)
    }
}
