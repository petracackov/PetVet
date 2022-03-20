//
//  FieldValidator.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import UIKit

class FieldValidator {
    private let username: String?
    private let email: String?
    private let password: String?
    private let confirmPassword: String?

    private var usernameValidated: Bool = true
    private var emailValidated: Bool = true
    private var passwordValidated: Bool = true

    init(validate fields: [Field], username: String? = nil, email: String? = nil, password: String? = nil, confirmPassword: String? = nil) {
        for field in fields {
            switch field {
            case .username: usernameValidated = false
            case .email: emailValidated = false
            case .password: passwordValidated = false
            }
        }
        self.username = username
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }

    enum Field {
        case username
        case email
        case password
    }

    enum Result {
        case OK
        case usernameAlreadyTaken
        case emailAlreadyTaken
        case emailInvalid
        case passwordDoesNotMatch

        var error: String {
            switch self {
            case .usernameAlreadyTaken: return "Uername is already taken"
            case .emailAlreadyTaken: return "Email is already taken"
            case .emailInvalid: return "Email is not the right format"
            case .OK: return "Evrything fine"
            case .passwordDoesNotMatch: return "Passwords do't match"
            }
        }
    }

    private var nameValid: Bool = true { didSet { checkValid() } }
    private var emailValid: Bool = true { didSet { checkValid() } }
    private var emailTaken: Bool = false { didSet { checkValid() } }
    private var passwordsMatch: Bool = true { didSet { checkValid() } }
    private var completion: ((_ result: Result) -> Void)?

    private var selfReference: FieldValidator?

    func validate(_ completion: @escaping (_ result: Result) -> Void) {
        self.completion = completion
        selfReference = self
        if let username = username, username.count > 0 {
            User.usernameIsAlreadyTaken(username: username) { (taken, error)  in
                if let taken = taken {
                    self.usernameValidated = true
                    self.nameValid = !taken
                }
            }
        }
        if let email = email, email.count > 0 {
            User.emailIsAlreadyTaken(email: email) { (taken, error)  in

                if let taken = taken {
                    self.emailTaken = taken
                }
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

                self.emailValidated = true // has to be placet before the last email validation
                self.emailValid = emailTest.evaluate(with: email)
            }
        }

        if let password = password, let confirmPassword = confirmPassword {
            passwordValidated = true
            passwordsMatch = confirmPassword == password
        }
    }

    private func allChecked() -> Bool {
        guard usernameValidated, emailValidated, passwordValidated else { return false }
        return true
    }

    private func checkValid() {
        guard allChecked() else { return }
        if !nameValid { completion?(.usernameAlreadyTaken) }
        else if !emailValid { completion?(.emailInvalid) }
        else if emailTaken { completion?(.emailAlreadyTaken) }
        else if !passwordsMatch { completion?(.passwordDoesNotMatch) }
        else { completion?(.OK) }

        completion = nil
        selfReference = nil
    }

}

