//
//  MainView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct MainView: View {

    @State private var menuIsShown: Bool = false
    @State private var selectedItem: MenuVM.ListItems? = nil

    var body: some View {

        ZStack(alignment: .center) {
            CustomNavigationView {
                NavigationLink(destination: ProfileView(), tag: MenuVM.ListItems.user, selection: $selectedItem) { EmptyView() }
                PetProfileView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Menu") {
                                showMenu(true)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Edit") {
                                print("Edit tapped!")
                            }
                        }
                    }
            }
            if menuIsShown {
                menuView()
            }
        }
        .onTapGesture {
            showMenu(false)
        }

    }

    private func menuView() -> some View {
        return HStack {
            MenuView(isShown: $menuIsShown, selectedItem: $selectedItem)
            Spacer()
        }
        .transition(.move(edge: .leading))
        .zIndex(100)

    }

    private func showMenu(_ shouldShow: Bool) {
        withAnimation {
            menuIsShown = shouldShow
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
