//
//  ItemView.swift
//  PetVet
//
//  Created by Petra Cackov on 26/03/2022.
//

import SwiftUI

struct ItemView: View {

    var item: MenuVM.ListItems
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
        case .user: return AnyView(profileView())
        case .pet: return AnyView(petView())
        case .addNew: return AnyView(addNewView())
        }
    }

    func profileView() -> some View {
        return ZStack {
            Circle()
                .strokeBorder(Color.ui.white, lineWidth: 3)
                .background(Circle().fill(Color.ui.borderGray))
            .frame(width: 60, height: 60, alignment: .center)
            Text("🙂")
                .font(.system(size: 35))
        }
    }

    func petView() -> some View {
        return Circle()
            .foregroundColor(Color.ui.orange)
            .frame(width: 60, height: 60, alignment: .center)
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
        ItemView(item: .user)
    }
}
