//
//  MainVM.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import Foundation


class MainVM: LoadableViewModel<[Pet], Error> {

    override init() {
        super.init()
        fetchPets()
    }

    convenience init(pets: [Pet]) {
        self.init()
        Task {
            await injectState(.data(payload: pets))
        }
    }

    private func fetchPets() {
        guard let user = User.current else { return } // TODO
        Task {
            await injectState(.loading)
            do {
                await injectState(.data(payload: try await user.fetchPets()))
            } catch {
                await injectState(.error(payload: error))
            }
        }
    }

}
