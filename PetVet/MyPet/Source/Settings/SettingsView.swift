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
        List {
            Text("Add new pet")
                .asButton {
                    navigation.navigationPath.append(Navigation.SettingsPath.addNewPet)
                }
        }
    }
}

#Preview {
    SettingsView(viewModel: .init())
}
