//
//  MenuView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct MenuView: View {

    @Binding var isShown: Bool

    var body: some View {
        ZStack() {
            BackgroundView(color: .ui.gray)
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    circle()
                    circle()
                    circle()
                    circle()
                }
            }
        }
        .frame(width: 100)
        .gesture(
            DragGesture()
                .onEnded({ value in
                    if value.translation.width < 0 {
                        withAnimation {
                            isShown = false
                        }
                    }
                })
        )
    }

    func circle() -> some View {
        return Circle()
            .foregroundColor(Color.ui.orange)
            .frame(width: 60, height: 60, alignment: .center)
    }
}

struct MenuView_Previews: PreviewProvider {
    @State static var menuIsShown: Bool = true
    static var previews: some View {
        MenuView(isShown: $menuIsShown)
    }
}
