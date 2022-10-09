//
//  ProfileVM.swift
//  PetVet
//
//  Created by Petra Cackov on 09/10/2022.
//

import Foundation

class ProfileVM: ObservableObject {

    @Published var name: String = ""
    @Published var address: String = ""
    @Published var addressCountry: String = ""
    @Published var phoneNumber: String = ""
    @Published var editModeEnabled: Bool = false

    init() {
        updateValues()
    }

    func saveProfile() {
        User.current?.name = name
        User.current?.address = address
        User.current?.city = addressCountry
        User.current?.phoneNumber = phoneNumber

        User.current?.save { (success, error) in
            if success == false  {
                // TODO: handle error
            } else {
                self.editModeEnabled = false
            }
        }
    }

    func updateValues() {
        name = User.current?.name ?? ""
        address = User.current?.address ?? ""
        addressCountry = User.current?.city ?? ""
        phoneNumber = User.current?.phoneNumber ?? ""
    }
}
