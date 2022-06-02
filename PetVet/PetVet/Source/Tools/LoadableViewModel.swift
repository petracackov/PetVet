//
//  LoadableViewModel.swift
//  PetVet
//
//  Created by Petra Cackov on 01/06/2022.
//

import Foundation

class LoadableViewModel<DataType, ErrorType>: ObservableObject {

    enum State {
        case undetermined
        case loading
        case error(payload: ErrorType)
        case data(payload: DataType)
    }

    @Published private(set) var state: State = .undetermined

    @MainActor func injectState(_ state: State) {
        self.state = state
    }

}
