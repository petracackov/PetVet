//
//  MenuVM.swift
//  PetVet
//
//  Created by Petra Cackov on 26/03/2022.
//

import Foundation
import SwiftUI

class MenuVM: ObservableObject {

    private let pets: [Pet]
    private let isLoading: Bool

    init(pets: [Pet], isLoading: Bool) {
        self.pets = pets
        self.isLoading = isLoading
    }

    var items: [ListItems] {
        let items: [ListItems] = [.user] + pets.map { .pet($0) }
        return isLoading ? items + [.loading] : items + [.addNew]
    }

    enum ListItems: Identifiable, Equatable {
        static func == (lhs: MenuVM.ListItems, rhs: MenuVM.ListItems) -> Bool {
            lhs.id == rhs.id
        }

        var id: String {
            switch self {
            case .loading: return "loading"
            case .user: return "user"
            case .pet(let pet): return pet.id ?? "pet"
            case .addNew: return "addNew"
            }
        }
        case user
        case pet(Pet)
        case addNew
        case loading
    }

}
