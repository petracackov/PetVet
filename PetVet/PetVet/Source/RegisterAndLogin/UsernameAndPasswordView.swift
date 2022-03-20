//
//  UsernameAndPasswordView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct UsernameAndPasswordView: View {
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            CustomTextFieldView(title: "Username")
            CustomTextFieldView(title: "Password")
            Spacer()
            CustomNavigationButton(buttonTitle: "Login") {
                MainView()
            }
        }
        .padding()
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UsernameAndPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameAndPasswordView()
    }
}
