//
//  TabBarView.swift
//  PetVet
//
//  Created by Petra Cackov on 15/05/2022.
//

import SwiftUI

struct TabBarView: View {

    @Binding var selectedTab: Tab

    var onActionButtonPress: (() -> Void)?

    enum Tab {
        case pets
        case home

        var imageIcon: UIImage {
            switch self {
            case .home: return R.image.tabBarHome()!
            case .pets: return R.image.tabBarPaw()!
            }
        }

        var imageSelectedIcon: UIImage {
            switch self {
            case .home: return R.image.tabBarHomeSelected()!
            case .pets: return R.image.tabBarPawSelected()!
            }
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                BackgroundView(color: Color.ui.white)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: -3)
                HStack(alignment: .center) {
                    Spacer()

                    tabButton(.home, isSelected: selectedTab == .home) {
                        selectTab(.home)
                    }
                    Spacer()
                    addMoreButton()
                    Spacer()

                    tabButton(.pets, isSelected: selectedTab == .pets) {
                        selectTab(.pets)
                    }

                    Spacer()
                }
            }
            .frame(height: 76)
        }

    }

    private func tabButton(_ item: Tab, isSelected: Bool,  action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(uiImage: isSelected ? item.imageSelectedIcon : item.imageIcon)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func addMoreButton() -> some View {
        Button {
            onActionButtonPress?()
        } label: {
            ZStack {
                BackgroundView(gradientColors: Appearance.Gradient.purple.colors)

                Rectangle()
                    .foregroundColor(.petVet(.white))
                    .rounded()
                    .padding(.horizontal, 25)
                    .padding(.vertical, 35)

                Rectangle()
                    .foregroundColor(.petVet(.white))
                    .rounded()
                    .padding(.horizontal, 35)
                    .padding(.vertical, 25)

            }
        }
        .frame(width: 72, height: 72)
        .rounded()
        .offset(CGSize(width: 0, height: -35))
        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: -2)
    }

    private func selectTab(_ tab: Tab) {
        withAnimation {
            selectedTab = tab
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    @State static private var selectedTab: TabBarView.Tab = .home
    static var previews: some View {
        TabBarView(selectedTab: $selectedTab)
    }
}
