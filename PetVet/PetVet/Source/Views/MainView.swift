//
//  MainView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct MainView: View {

    @State private var menuIsShown: Bool = false

    var body: some View {

        ZStack(alignment: .center) {
            CustomNavigationView {
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
            MenuView(isShown: $menuIsShown)
            Spacer()
        }
        .transition(.move(edge: .leading))
        .zIndex(1)

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
