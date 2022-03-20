//
//  PetVetApp.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

@main
struct PetVetApp: App {

    init() {
        ParseManager.initialize()
    }

    var body: some Scene {
        WindowGroup {
            LaunchScreen()
        }
    }
}
