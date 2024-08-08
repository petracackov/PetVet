//
//  ViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 11. 7. 24.
//

import Foundation
import Combine

@Observable class ViewModel {
    
    var cancelable = Set<AnyCancellable>()
    private(set) var error: AppError?
    var alertIsShown: Bool = false
    
    func handleError(_ error: Error?) {
        guard let error = error else { return }
        if let appError = error as? AppError {
            handleError(appError)
        } else {
            handleError(.general(error))
        }
    }
    
    func handleError(_ error: AppError) {
        self.error = error
        alertIsShown = true
    }
    
}
