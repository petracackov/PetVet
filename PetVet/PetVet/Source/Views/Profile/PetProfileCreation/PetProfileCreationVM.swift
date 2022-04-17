//
//  PetProfileCreationVM.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import Foundation


class PetProfileCreationVM: ObservableObject {

    @Published var selectedGender: Int = 0

    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"

        var index: Int { Gender.allCases.firstIndex(of: self) ?? 0 }
    }

}
