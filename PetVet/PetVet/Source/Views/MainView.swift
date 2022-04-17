//
//  MainView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct MainView: View {

    @State var menuIsShown: Bool = false
    @ObservedObject var viewModel: MainVM = MainVM()

    var body: some View {

        ZStack(alignment: .center) {
            CustomNavigationView {

                NavigationLink(
                    destination: ProfileView(),
                    isActive: $viewModel.showProfile
                ) {
                   EmptyView()
                }

                NavigationLink(
                    destination: ProfileView(),
                    isActive: $viewModel.showProfile
                ) {
                   EmptyView()
                }

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
                    .onTapGesture {
                        if menuIsShown {
                            showMenu(false)
                        }
                    }
            }

            if menuIsShown {
                menuView()
            }
        }


    }

    private func menuView() -> some View {
        return HStack {
            MenuView(pets: viewModel.pets, isShown: $menuIsShown, selectedItem: $viewModel.selectedItem)
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

