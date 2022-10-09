//
//  SettingsView.swift
//  PetVet
//
//  Created by Petra Cackov on 09/10/2022.
//

import SwiftUI

struct SettingsView: View {

    @State private var profileIsShown: Bool = false
    @State private var petCreationIsShown: Bool = false

    var body: some View {
        ZStack {

            BackgroundView(gradientColors: Appearance.Gradient.purpleTransparent.colors)
            VStack(spacing: 0) {
                VStack(spacing: 0) {

                    Button(action: { profileIsShown = true }, label: {
                        item(title: "Profile")
                            .font(.ui.title)
                            .foregroundColor(.petVet(.blackWhite))
                    })
                    .navigate(to: ProfileView(), when: $profileIsShown)


                    Button(action: { petCreationIsShown = true }, label: {
                        item(title: "Add New Pet")
                            .font(.ui.title)
                            .foregroundColor(.petVet(.blackWhite))

                    })
                    .navigate(to: PetProfileCreationView(), when: $petCreationIsShown)
                }
                .padding(.horizontal)
                .padding(.vertical, 45)

                VStack(spacing: 0) {
                    Button(action: {
                        User.logOut()
                    }, label: {
                        item(title: "Log Out", showArrow: false)
                            .font(.ui.titleBold)
                            .foregroundColor(.petVet(.blackWhite))
                    })

                    Button(action: {
                        print("delete")
                    }, label: {
                        item(title: "Delete account", showArrow: false)
                            .font(.ui.titleBold)
                            .foregroundColor(.petVet(.orange))
                    })
                }
                .padding(.horizontal)
                Spacer()
            }
        }
    }

    private func item(title: String, showArrow: Bool = true) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                VStack {
                    Spacer()
                    Text(title)
                        .padding(.vertical, 5)
                }

                Spacer()
                if showArrow {
                    Image(uiImage: R.image.chevronRight()!)
                        .renderingMode(.template)
                        .foregroundColor(.petVet(.blackWhite))
                }
            }

            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.petVet(.gray3))
        }
        .frame(height: 60)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
