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
        NavigationView {
            ZStack(alignment: .leading) {
                BackgroundView(color: .ui.background)
                ProfileView()
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
            .navigationBarTitleDisplayMode(.inline)
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
