//
//  RegistrationAndLoginView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct RegistrationAndLoginView: View {

    var body: some View {
        CustomNavigationView() {
            VStack(spacing: 30) {
                Spacer()
                ProfileHeaderView()
                Spacer()
                CustomNavigationButton(buttonTitle: "Login") {
                    UsernameAndPasswordView(isRegistrationFlow: false)
                }
                CustomNavigationButton(buttonTitle: "Register") {
                    UsernameAndPasswordView(isRegistrationFlow: true)
                }

            }
            .padding()
        }
        .navigationBarHidden(true)

    }
}

struct RegistrationAndLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationAndLoginView()
    }
}
