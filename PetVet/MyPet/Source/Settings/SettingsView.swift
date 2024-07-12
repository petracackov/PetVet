//
//  SettingsView.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: SettingsViewModel
    
    var body: some View {
        List {
            Text("Add new pet")
                .asButton {
                    navigation.navigationPath.append(Navigation.SettingsPath.addNewPet)
                }
            Text("Sync with icloud - TODO")
                .asButton {
                    navigation.navigationPath.append(Navigation.SettingsPath.addNewPet)
                }
            Text("Mh vet info - TODO")
                .asButton {
                    navigation.navigationPath.append(Navigation.SettingsPath.addNewPet)
                }
            
        }
    }
}

#Preview {
    SettingsView(viewModel: .init())
}
