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
    @Published var showPetCreationView: Bool = false

    private func handleSelectedItemChange() {

        hideAllViews()

        switch selectedItem {
        case .user: showProfile = true
        case .addNew: showPetCreationView = true
        case .pet: return
        case .none: return
        }
    }


    func hideAllViews() {
        showProfile = false
        showPetCreationView = false
    }

}
