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
                
                content()
    
                menu()
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.dashboardItem.title)
            
        }
        .accentColor(.appPurple)
    }
    
    private func content() -> some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(DashboardItem.allCases) { item in
                        switch item {
                        case .events:
                            EventsView(viewModel: .init(dataService: viewModel.dataService))
                                .frame(width: proxy.size.width)
                                .id(item.scrollPosition)
                        case .home:
                            HomeView(viewModel: .init(dataService: viewModel.dataService))
                                .frame(width: proxy.size.width)
                                .id(item.scrollPosition)
                        case .settings:
                            SettingsView(viewModel: .init(dataService: viewModel.dataService))
                                .frame(width: proxy.size.width)
                                .id(item.scrollPosition)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollDisabled(true)
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            .scrollPosition(id: $viewModel.scrollPosition)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
            .foregroundStyle(item.scrollPosition == viewModel.scrollPosition ? .appPurple : .appText)
            .asButton {
                viewModel.scrollPosition = item.scrollPosition
            }
    }
    
}
