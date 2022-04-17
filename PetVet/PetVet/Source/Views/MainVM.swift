//
//  MainVM.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import Foundation

class MainVM: ObservableObject {

    var pets: [Pet] = []
    var selectedItem: MenuVM.ListItems? = nil {
        didSet {
            handleSelectedItemChange()
        }
    }

    @Published var showProfile: Bool = false

    private func handleSelectedItemChange() {
        switch selectedItem {
        case .user: showProfile = true
        case .addNew: return
        case .pet: return
        case .none: return
        }
    }

}
