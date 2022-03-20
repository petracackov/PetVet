//
//  UsernameAndPasswordVM.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation
import SwiftUI

class UsernameAndPasswordVM {

    var isRegistrationFlow: Bool
    var buttonTitle: String { isRegistrationFlow ? "Register" : "Login" }
    var navigationTitle: String { isRegistrationFlow ? "Registration" : "Login" }

    init(isRegistrationFlow: Bool) {
        self.isRegistrationFlow = isRegistrationFlow
    }

    func onButtonPress(username: String, email: String, password: String, confirmPassword: String) {
        if isRegistrationFlow {
            validateAndSignUp(username: username, email: email, password: password, confirmPassword: confirmPassword)
        } else {
            login(username: username, password: password)
        }
    }

    private func validateAndSignUp(username: String, email: String, password: String, confirmPassword: String) {
        FieldValidator.init(validate: [.username, .email, .password], username: username, email: email, password: password, confirmPassword: confirmPassword).validate { result in
            switch result {
            case .OK:
                self.signUpNewUser(username: username, password: password, email: email)
            case .emailInvalid, .emailAlreadyTaken, .usernameAlreadyTaken, .passwordDoesNotMatch:
                // TODO: trigger some error
                break
            }
        }
    }

    private func signUpNewUser(username: String, password: String, email: String) {
        LoginManager.signUpUser(username: username, password: password, email: email) { user, error in
            if user != nil {
                LoginManager.shared.userRegistrationInProgress = true
                LoginManager.shared.isLoggedIn = true
            } else {
                // TODO: handle error
            }
        }
    }

    private func login(username: String, password: String) {
        LoginManager.logIn(username: username, password: password) { user, error in
            if user != nil {
                LoginManager.shared.userRegistrationInProgress = false
                LoginManager.shared.isLoggedIn = true
            } else {
                // TODO: handle error
            }
        }
    }

}
