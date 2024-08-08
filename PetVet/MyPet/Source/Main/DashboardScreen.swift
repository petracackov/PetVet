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
    @State var navigation = Navigation.shared
    @Namespace var internalNamespace
    
    var body: some View {
        NavigationStack(path: $navigation.navigationPath) {
            ZStack(alignment: .bottom) {
                
                content()
    
                if !navigation.tabBarIsHidden {
                    menu()
                        .globalElementId("menu", namespace: internalNamespace)
                        .zIndex(2) // Because of the animation
                        .transition(.move(edge: .bottom))
                }
                
            }
            .animation(.easeInOut, value: navigation.tabBarIsHidden)
            .ignoresSafeArea(edges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle(viewModel.dashboardItem.title)
            .navigationBarTitle(viewModel.dashboardItem.title)
            
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
                            HomeView(viewModel: .init(dataService: viewModel.dataService), internalNamespace: internalNamespace)
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
            .defaultScrollAnchor(.center)
            
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
                withAnimation {
                    viewModel.scrollPosition = item.scrollPosition
                }
            }
    }
    
}
