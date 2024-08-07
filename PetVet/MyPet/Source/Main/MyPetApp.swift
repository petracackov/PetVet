//
//  MyPetApp.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI

@main
struct MyPetApp: App {
    
    @State private var isShowingLaunchScreen: Bool = true
    private let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isShowingLaunchScreen {
                    LaunchScreenUI()
                        
                } else {
                    DashboardScreen(viewModel: .init(dataService: DataService(dataSource: DataSource.shared)))
                }
            }
            .animation(.easeInOut, value: isShowingLaunchScreen)
            .onReceive(timer, perform: { _ in
                hideLaunchScreen()
            })
        }
    }
    
    private func hideLaunchScreen() {
        isShowingLaunchScreen = false
        timer.upstream.connect().cancel()
    }

}
