//
//  ContentView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct ContentView: View {

    @State var menuIsShown: Bool = false

    var body: some View {
        CustomNavigationView {
            ZStack(alignment: .leading) {
                BackgroundView(color: .ui.background)
                ProfileView()
                CustomButtonView(title: "Log out", backgroundColor: .ui.purple) {
                    User.logOut()
                }
                if menuIsShown {
                    MenuView(isShown: $menuIsShown)
                        .transition(.move(edge: .leading))
                        .zIndex(1)
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

    func showMenu(_ shouldShow: Bool) {
        withAnimation {
            menuIsShown = shouldShow
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
