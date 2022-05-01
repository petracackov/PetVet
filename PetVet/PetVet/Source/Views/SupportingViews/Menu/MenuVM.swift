//
//  MenuVM.swift
//  PetVet
//
//  Created by Petra Cackov on 26/03/2022.
//

import Foundation
import SwiftUI

class MenuVM {

    let pets: [Pet]

    var items: [ListItems] { [ListItems.user] + pets.map { _ in ListItems.pet } + [ListItems.addNew] }

    enum ListItems: Identifiable {
        var id: Self { self }

        case user
        case pet
        case addNew
    }

    init(pets: [Pet]) {
        self.pets = pets
    }

}
