//
//  TabBarView.swift
//  PetVet
//
//  Created by Petra Cackov on 15/05/2022.
//

import SwiftUI

struct TabBarView: View {

    @Binding var selectedTab: Tab

    enum Tab {
        case pets
        case home
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                BackgroundView(color: Color.ui.white)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: -3)
                HStack(alignment: .center) {
                    Spacer()
//                    tabButton(image: R.image.pawTabIcon(), isSelected: selectedTab == .pets) {
//                        selectedTab = .pets
//                    }
                    Spacer()
                    RoundedButton(
                        title: "+",
                        backgroundColor: .ui.purple,
                        titleColor: .ui.white) {
                            print("xcv")
                        }
                        .frame(width: 70, height: 70)
                        .offset(CGSize(width: 0, height: -35))
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: -2)
                    Spacer()

//                    tabButton(image: R.image.pawTabIcon(), isSelected: selectedTab == .home) {
//                        selectedTab = .home
//                    }

                    Spacer()
                }
            }
            .frame(height: 76)
        }

    }

    func tabButton(image: UIImage, isSelected: Bool,  action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(uiImage: image)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(isSelected ? .ui.purple : .ui.gray)
    }
}

struct TabBarView_Previews: PreviewProvider {
    @State static private var selectedTab: TabBarView.Tab = .home
    static var previews: some View {
        TabBarView(selectedTab: $selectedTab)
    }
}
