//
//  ProfileCreationVM.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation

class ProfileCreationVM {

    func editProfile(name: String, address: String, city: String, phoneNumber: String) {
        User.current?.name = name
        User.current?.address = address
        User.current?.city = city
        User.current?.phoneNumber = phoneNumber

        User.current?.save { (success, error) in
            if success == false  {
                // TODO: handle error
            } else {
                if LoginManager.shared.userRegistrationInProgress {
                    LoginManager.shared.userRegistrationInProgress = false
                } else {
                    // TODO: close
                }
            }
        }
    }
}
