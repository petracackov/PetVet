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
                    NoDataView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.red)
                        .toolbar(.hidden, for: .tabBar)
                        .tag(DashboardItem.events)
                    HomeView(viewModel: .init(dataSource: viewModel.dataSource))
                        .toolbar(.hidden, for: .tabBar)
                        .ignoresSafeArea(edges: .bottom)
                        .tag(DashboardItem.home)
                    SettingsView(viewModel: .init(dataSource: viewModel.dataSource))
                        .toolbar(.hidden, for: .tabBar)
                        .tag(DashboardItem.settings)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabViewStyle(.page(indexDisplayMode: .never))
    
                menu()
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.appPurpleGradient, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(viewModel.dashboardView.title)

            
        }
        .accentColor(.appPurple)
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
