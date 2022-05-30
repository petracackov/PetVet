//
//  MainVM.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import Foundation

class MainVM: ObservableObject {

    private(set) var pets: [Pet] = []
    @Published var showProfile: Bool = false
    @Published var showPetCreationView: Bool = false
    @Published var showUserProfileView: Bool = false
    @Published private(set) var isLoading: Bool = false

    init() {
        fetchPets()
    }

    private func fetchPets() {
        isLoading = true
        User.current?.fetchPets(completion: { [weak self] objects, error in
            guard let self = self else { return }
            self.isLoading = false
            self.pets = objects ?? []
        })
    }

}
