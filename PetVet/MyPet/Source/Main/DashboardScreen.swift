//
//  DashboardScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

struct DashboardScreen: View {
    
    typealias DashboardItem = DashboardViewModel.DashboardItem
    
    @State var viewModel: DashboardViewModel
    @EnvironmentObject var navigation: Navigation
    
    var body: some View {
        NavigationStack(path: $navigation.navigationPath) {
            ZStack(alignment: .bottom) {
                TabView(selection: $viewModel.dashboardView) {
                    MyPetsScreen(viewModel: .init(dataSource: viewModel.dataSource))
                        .navigationTitle("MyPets")
                        .toolbar(.hidden, for: .tabBar)
                        .tag(DashboardItem.home)
                    SettingsScreen(viewModel: .init(dataSource: viewModel.dataSource))
                        .navigationTitle("Settings")
                        .toolbar(.hidden, for: .tabBar)
                        .tag(DashboardItem.settings)
                    NoDataView()
                        .padding()
                        .navigationTitle("Reminders")
                        .tag(DashboardItem.events)
                        .toolbar(.hidden, for: .tabBar)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                menu()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.dashboardView.title)
            
        }
    }
    
    private func menu() -> some View {
        HStack(spacing: 0) {
            menuItem(.events)
            menuItem(.home)
            menuItem(.settings)
        }
        .background(.regularMaterial, in: .capsule)
        .padding(.bottom, 25)
    }
    
    private func menuItem(_ item: DashboardItem) -> some View {
        item.image
            .resizable()
            .scaledToFit()
            .frame(height: 30)
            .padding(25)
            .foregroundStyle(item == viewModel.dashboardView ? .appPurple : .appText)
            .asButton {
                viewModel.dashboardView = item
            }
    }
    
}
