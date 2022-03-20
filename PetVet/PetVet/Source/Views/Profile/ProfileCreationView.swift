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

    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Spacer()
                CustomTextFieldView(title: "Full Name", text: $name)
                CustomTextFieldView(title: "Address", text: $address)
                CustomTextFieldView(title: "City", text: $city)
                CustomTextFieldView(title: "Phone Number", text: $phoneNumber)
                Spacer()
                CustomNavigationButton(buttonTitle: "Save") {
                    ContentView()
                }
            }
            .padding()

        }.navigationTitle("Registration")
    }
}

struct ProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationView()
    }
}
