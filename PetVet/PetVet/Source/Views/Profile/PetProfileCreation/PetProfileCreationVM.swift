//
//  PetProfileCreationVM.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import Foundation
import UIKit


class PetProfileCreationVM: ObservableObject {

    var buttonTitle: String = "Add Pet"

    func createPet(name: String, gender: Pet.Gender, dateOfBirth: Date, type: Pet.PetType, image: UIImage?, transponderCode: String, transponderLocation: String) {
        guard let ownerId = User.current?.userId else { return }
        let pet = Pet(name: name,
                      ownerId: ownerId,
                      gender: gender,
                      dateOfBirth: dateOfBirth,
                      type: type,
                      image: image,
                      transponderCode: transponderCode.isEmpty ? nil : transponderCode,
                      transponderLocation: transponderLocation.isEmpty ? nil : transponderLocation)

        pet.save { success, error in
            // TODO
            print(success, error)
        }
    }

    func updatePet() {
        // TODO
    }

}
