//
//  ProfileView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct ProfileView: View {

    @ObservedObject private var viewModel = ProfileVM()

    var body: some View {
        ZStack {
            BackgroundView(gradientColors: Appearance.Gradient.purpleTransparent.colors)
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    CustomLineTextField(title: "Name", textFieldIsDisabled: !viewModel.editModeEnabled, text: $viewModel.name)
                    CustomLineTextField(title: "Adress", textFieldIsDisabled: !viewModel.editModeEnabled, text: $viewModel.address)
                    CustomLineTextField(title: "City and country", textFieldIsDisabled: !viewModel.editModeEnabled, text: $viewModel.addressCountry)
                    CustomLineTextField(title: "Phone number", textFieldIsDisabled: !viewModel.editModeEnabled, text: $viewModel.phoneNumber).keyboardType(.phonePad)
                    if viewModel.editModeEnabled {
                        CustomButtonView(title: "Save") {
                            viewModel.saveProfile()
                        }
                            .padding(.vertical)
                    }
                }.padding()
            }
        }
        .navigationTitle(Text("Profile"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.editModeEnabled.toggle()
                    viewModel.updateValues()
                } label: {
                    Image(uiImage: R.image.editIcon()!)
                        .renderingMode(.template)
                        .tint(.petVet(viewModel.editModeEnabled ? .orange : .blackWhite))
                }

            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            ProfileView()
        }
    }
}
