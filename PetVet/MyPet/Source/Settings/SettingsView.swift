//
//  SettingsView.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

struct SettingsView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: SettingsViewModel
    
    var body: some View {
        ZStack {
            List {
                Text("Add new pet")
                    .asButton {
                        navigation.navigationPath.append(Navigation.SettingsPath.addNewPet)
                    }
                Text("Sync with icloud - TODO")
                    .asButton {
                        print("Sync with icloud - TODO")
                    }
                Text("My vet info - TODO")
                    .asButton {
                        print("My vet info - TODO")
                    }
                
            }
        }
        .navigationDestination(for: Navigation.SettingsPath.self) { path in
            switch path {
            case .addNewPet:
                ManagePetView(viewModel: ManagePetViewModel(dataService: viewModel.dataService, pet: nil))
            }
        }
    }
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return SettingsView(viewModel: .init(dataService: dataService))
}
