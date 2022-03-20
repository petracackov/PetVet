//
//  RegistrationandLoginView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct RegistrationandLoginView: View {

    @State var goToLoginScreen: Bool = false
    @State var goToRegistrationScreen: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Spacer()
                ProfileHeaderView()
                Spacer()
                NavigationLink(
                    destination: UsernameAndPasswordView(), isActive: $goToLoginScreen) {
                    CustomButtonView(title: "Login") {
                        goToLoginScreen = true
                    }
                }

                NavigationLink(
                    destination: UsernameAndPasswordView(), isActive: $goToRegistrationScreen) {
                    CustomButtonView(title: "Register") {
                        goToRegistrationScreen = true
                    }
                }

            }
            .padding()
        }
        .navigationBarHidden(true)

    }
}

struct RegistrationandLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationandLoginView()
    }
}
