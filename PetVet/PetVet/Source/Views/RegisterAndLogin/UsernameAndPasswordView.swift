//
//  UsernameAndPasswordView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct UsernameAndPasswordView: View {

    private var viewModel: UsernameAndPasswordVM
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordConformation: String = ""
    @State var email: String = ""

    init(isRegistrationFlow: Bool) {
        viewModel = UsernameAndPasswordVM(isRegistrationFlow: isRegistrationFlow)
    }

    var body: some View {
        VStack(spacing: 40) {

            Spacer()

            CustomTextFieldView(title: "Username", text: $username)

            if viewModel.isRegistrationFlow {
                CustomTextFieldView(title: "Email", text: $email)
            }

            CustomTextFieldView(title: "Password", text: $password)

            if viewModel.isRegistrationFlow {
                CustomTextFieldView(title: "Confirm Password", text: $passwordConformation)
            }

            Spacer()

            CustomButtonView(title: viewModel.buttonTitle) {
                viewModel.onButtonPress(username: username, email: email, password: password, confirmPassword: passwordConformation)
            }
        }
        .padding()
        .navigationTitle(viewModel.navigationTitle)
    }
}

struct UsernameAndPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameAndPasswordView(isRegistrationFlow: true)
    }
}
