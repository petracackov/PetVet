//
//  MyPetApp.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI

@main
struct MyPetApp: App {
    
    @State private var navigation = Navigation()
    
    var body: some Scene {
        WindowGroup {
            DashboardScreen(viewModel: .init(dataSource: DataSource.shared))
                .environmentObject(navigation)
        }
    }
}
