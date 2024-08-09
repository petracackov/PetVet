//
//  MyVetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 8. 8. 24.
//

import SwiftUI

@Observable class MyVetViewModel: ViewModel {
    
    var vets: [VetInfo]
    let dataService: DataService
    
    init(dataService: DataService, vets: [VetInfo] = []) {
        self.vets = vets
        self.dataService = dataService
        super.init()
    }
    
}

