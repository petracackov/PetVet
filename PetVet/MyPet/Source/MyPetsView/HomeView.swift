//
//  HomeView.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

struct HomeView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: MyPetsViewModel
    var internalNamespace: Namespace.ID
    
    var body: some View {
        ZStack {
            switch viewModel.dataState {
            case .data:
                MyPetsView(viewModel: viewModel, namespace: internalNamespace)
            case .oneItem(let pet):
                MyPetView(viewModel: .init(dataService: viewModel.dataService, pet: pet))
            case .empty:
                NoDataView(.generic) {
                    navigation.navigationPath.append(Navigation.MyPetsPath.createNewPet)
                }
            case .error(let error):
                NoDataView(.generic, title: error.description)
            }
            
            if let selectedPet = viewModel.selectedPet {
                MyPetView(viewModel: .init(dataService: viewModel.dataService, pet: selectedPet), namespace: internalNamespace)
                    .navigationTitle("My Pet")
                    .toolbarItem(.systemIconChevronLeft, placement: .navigation) {
                        viewModel.selectedPet = nil
                    }
                   
            }
        }
        .onChange(of: viewModel.selectedPet) { oldValue, newValue in
            navigation.tabBarIsHidden = newValue != nil
        }
        .animation(.easeInOut, value: viewModel.selectedPet)
        .appAlert(error: viewModel.error, isPresented: $viewModel.alertIsShown)
        .navigationDestination(for: Navigation.MyPetsPath.self, destination: { path in
            switch path {
            case .pet(let pet):
                MyPetView(viewModel: .init(dataService: viewModel.dataService, pet: pet))
            case .createNewPet:
                ManagePetView(viewModel: ManagePetViewModel(dataService: viewModel.dataService, pet: nil))
            }
            
        })
        
    }
    
}
