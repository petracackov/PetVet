//
//  LoginManager.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation
import Parse

class LoginManager: ObservableObject {

    static var shared: LoginManager = LoginManager()

    @Published var isLoggedIn: Bool = false
    @Published var userRegistrationInProgress: Bool = false

    init() {
        isLoggedIn = User.current != nil
    }

    static func logIn(username: String, password: String, _ completion: ((_ user: PFUser?, _ error: Error?) -> Void)? = nil) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            completion?(user, error)
        }
    }

    static func signUpUser(username: String, password: String, email: String,  _ completion: ((_ user: Bool?, _ error: Error?) -> Void)? = nil)  {
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        user.signUpInBackground { (success, error) in
            completion?(success, error)
        }
    }

}
