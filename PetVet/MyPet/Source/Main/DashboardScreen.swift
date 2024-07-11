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
    
    var body: some View {
        NavigationStack(path: $navigation.navigationPath) {
            ZStack(alignment: .bottom) {
                TabView(selection: $viewModel.dashboardView) {
                    MyPetsScreen(viewModel: .init(modelContext: viewModel.modelContext))
                        .navigationTitle("MyPets")
                        .toolbar(.hidden, for: .tabBar)
                        .tag(DashboardItem.home)
                    SettingsScreen(viewModel: .init(modelContext: viewModel.modelContext))
                        .navigationTitle("Settings")
                        .toolbar(.hidden, for: .tabBar)
                        .tag(DashboardItem.settings)
                    NoDataView()
                        .padding()
                        .navigationTitle("Reminders")
                        .toolbar(.hidden, for: .tabBar)
                        .tag(DashboardItem.events)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                menu()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.dashboardView.title)
            
//            .navigationDestination(for: Navigation.Path.self) { path in
//                switch path {
//                case .medicalRecords(let pet):
//                    MedicalRecordsScreen(viewModel: .init(modelContext: viewModel.modelContext, pet: pet))
//                case .reminders:
//                    Text("Reminders")
//                case .manageMedicalRecord(let medicalRecord, let pet):
//                    ManageMedicalRecordScreen(viewModel: .init(modelContext: viewModel.modelContext,
//                                                               medicalRecord: medicalRecord,
//                                                               pet: pet))
//                case .managePet(let pet):
//                    ManagePetView(viewModel: ManagePetDataViewModel(modelContext: viewModel.modelContext, pet: pet))
//                case .pet(let pet):
//                    
//                }
//            }
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
