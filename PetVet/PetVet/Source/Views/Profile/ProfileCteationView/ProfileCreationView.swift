//
//  ProfileCreationView.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import SwiftUI

struct ProfileCreationView: View {
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var city: String = ""
    @State private var phoneNumber: String = ""

    private var viewModel = ProfileCreationVM()

    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Spacer()
                CustomTextFieldView(title: "Full Name", text: $name)
                CustomTextFieldView(title: "Address", text: $address)
                CustomTextFieldView(title: "City", text: $city)
                CustomTextFieldView(title: "Phone Number", text: $phoneNumber)
                Spacer()
                CustomButtonView(title: "Save") {
                    viewModel.editProfile(
                        name: name,
                        address: address,
                        city: city,
                        phoneNumber: phoneNumber)
                }
            }
            .padding()

        }.navigationTitle("Profile")
    }
}

struct ProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            ProfileCreationView()
        }
    }
}
