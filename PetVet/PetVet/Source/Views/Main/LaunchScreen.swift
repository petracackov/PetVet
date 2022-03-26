//
//  LaunchScreen.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import SwiftUI

struct LaunchScreen: View {

    @ObservedObject var loginManager = LoginManager.shared

    var body: some View {
        if loginManager.isLoggedIn {
            if loginManager.userRegistrationInProgress {
                ProfileCreationView()
            } else {
                MainView()
            }
        } else {
            RegistrationAndLoginView()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
