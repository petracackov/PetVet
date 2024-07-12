//
//  SettingsScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 11. 7. 24.
//

import SwiftUI

struct SettingsScreen: View {
    
    @State var viewModel: SettingsDataViewModel
    
    var body: some View {
        SettingsView(viewModel: viewModel)
            .navigationDestination(for: Navigation.SettingsPath.self) { path in
                switch path {
                case .addNewPet:
                    ManagePetView(viewModel: ManagePetDataViewModel(dataSource: viewModel.dataSource, pet: nil))
                }
            }
    }
}
