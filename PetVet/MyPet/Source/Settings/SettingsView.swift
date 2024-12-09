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
                    .font(.body)
                    .foregroundStyle(.appText)
                    .asButton {
                        navigation.navigationPath.append(Navigation.SettingsPath.addNewPet)
                    }
                Text("Sync with icloud - TODO")
                    .font(.body)
                    .foregroundStyle(.appText)
                    .asButton {
                        print("Sync with icloud - TODO")
                    }
                Text("My vet info")
                    .font(.body)
                    .foregroundStyle(.appText)
                    .asButton {
                        navigation.navigationPath.append(Navigation.SettingsPath.vets)
                    }
                
            }
        }
        .navigationDestination(for: Navigation.SettingsPath.self) { path in
            switch path {
            case .addNewPet:
                ManagePetView(viewModel: ManagePetViewModel(dataService: viewModel.dataService, pet: nil))
            case .vets:
                MyVetView(viewModel: .init(dataService: viewModel.dataService, vets: MockedData.vetInfo))
            }
        }
    }
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return SettingsView(viewModel: .init(dataService: dataService))
}
