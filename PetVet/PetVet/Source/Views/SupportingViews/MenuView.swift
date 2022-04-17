//
//  MenuView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct MenuView: View {

    @Binding var isShown: Bool
    @Binding var selectedItem: MenuVM.ListItems?

    init(pets: [Pet], isShown: Binding<Bool>, selectedItem: Binding<MenuVM.ListItems?>) {
        self.viewModel = MenuVM(pets: pets)
        _isShown = isShown
        _selectedItem = selectedItem
    }

    private let viewModel: MenuVM

    var body: some View {
        ZStack() {
            BackgroundView(color: .ui.borderGray)
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    ForEach(viewModel.items) { item in
                        ItemView(item: item) { selectedItem in
                            hideView()
                            self.selectedItem = selectedItem
                        }
                    }
                }
            }
        }
        .frame(width: 100)
        .gesture(
            DragGesture()
                .onEnded({ value in
                    if value.translation.width < 0 {
                        hideView()
                    }
                })
        )
    }

    private func hideView() {
        withAnimation {
            isShown = false
        }
    }

}

struct MenuView_Previews: PreviewProvider {
    @State static var menuIsShown: Bool = true
    @State static var selectedItem: MenuVM.ListItems? = .user
    static var previews: some View {
        MenuView(pets: [], isShown: $menuIsShown, selectedItem: $selectedItem)
    }
}
