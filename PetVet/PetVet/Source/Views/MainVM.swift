//
//  MainVM.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import Foundation

class MainVM: ObservableObject {

    var selectedItem: MenuVM.ListItems? = nil {
        didSet {
            handleSelectedItemChange()
        }
    }

    var selectedPet: Pet? {
        guard case .pet(let pet) = selectedItem else { return nil }
        return pet
    }

    private(set) var pets: [Pet] = []
    @Published var showProfile: Bool = false
    @Published var showPetCreationView: Bool = false
    @Published private(set) var isLoading: Bool = false

    init() {
        fetchPets()
    }

    private func handleSelectedItemChange() {

        hideAllViews()

        switch selectedItem {
        case .user: showProfile = true
        case .addNew: showPetCreationView = true
        case .pet: return
        case .none: return
        case .loading: return
        }
    }


    func hideAllViews() {
        showProfile = false
        showPetCreationView = false
    }

    private func fetchPets() {
        isLoading = true
        User.current?.fetchPets(completion: { [weak self] objects, error in
            guard let self = self else { return }
            self.isLoading = false
            self.pets = objects ?? []
            if !self.pets.isEmpty, let pet = self.pets.first {
                self.selectedItem = .pet(pet)
            }
        })
    }

}
