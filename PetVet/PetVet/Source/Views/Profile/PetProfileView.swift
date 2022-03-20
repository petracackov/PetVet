//
//  PetProfileView.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import SwiftUI

struct PetProfileView: View {

    @State private var menuIsShown: Bool = false
    private var viewModel = PetProfileVM()

    var body: some View {
        CustomNavigationView {
            ZStack(alignment: .center) {

                BackgroundView(color: .ui.background)

                if viewModel.pets.isEmpty {
                    showNoPetsView()
                } else {
                    showPetProfile()
                }

                if menuIsShown {
                    menuView()
                }
            }
            .onTapGesture {
                showMenu(false)
            }
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
    }

    private func showPetProfile() -> some View {
        return ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProfileHeaderView()
            }

        }.padding()
    }

    private func showNoPetsView() -> some View {
        return ProfileHeaderView(title: "You have no pets yet").edgesIgnoringSafeArea(.all)
    }

    private func menuView() -> some View {
        return MenuView(isShown: $menuIsShown)
            .transition(.move(edge: .leading))
            .zIndex(1)
    }

    private func showMenu(_ shouldShow: Bool) {
        withAnimation {
            menuIsShown = shouldShow
        }
    }
}

struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView()
    }
}
