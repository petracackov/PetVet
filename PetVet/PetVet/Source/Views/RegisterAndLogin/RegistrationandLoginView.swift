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
            ZStack {
                BackgroundView(gradientColors: Appearance.Gradient.purpleTransparent.colors)
                VStack(spacing: 30) {
                    Spacer()
                    Image(uiImage: R.image.logo()!)
                    Spacer()
                    CustomNavigationButton(buttonTitle: "LOG IN") {
                        UsernameAndPasswordView(isRegistrationFlow: false)
                    }
                    CustomNavigationButton(buttonTitle: "REGISTER") {
                        UsernameAndPasswordView(isRegistrationFlow: true)
                    }

                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct RegistrationAndLoginView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationAndLoginView()
    }
}
