//
//  MyPetScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI

struct MyPetScreen: View {
    
    @State var viewModel: MyPetDataViewModel
    
    var body: some View {
        PetView(viewModel: viewModel)
            .navigationDestination(for: Navigation.PetPath.self) { path in
                switch path {
                case .editPet:
                    ManagePetView(viewModel: ManagePetDataViewModel(dataSource: viewModel.dataSource, pet: viewModel.pet))
                case .medicalRecords:
                    MedicalRecordsScreen(viewModel: .init(dataSource: viewModel.dataSource, pet: viewModel.pet))
                case .reminders:
                    Text("Reminders")
                }
            }
    }
    
    
}
