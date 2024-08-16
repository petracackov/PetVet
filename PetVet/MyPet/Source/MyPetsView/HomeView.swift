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
    
    var body: some View {
        ZStack {
            switch viewModel.dataState {
            case .data:
                MyPetsView(viewModel: viewModel)
            case .oneItem(let pet):
                MyPetView(viewModel: .init(dataService: viewModel.dataService, pet: pet))
            case .empty:
                NoDataView(.generic, title: "+ Add new pet") {
                    navigation.navigationPath.append(Navigation.MyPetsPath.createNewPet)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .appGradient()
            case .error(let error):
                NoDataView(.generic, title: error.description)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .appGradient()
            }
            
            if let selectedPet = viewModel.selectedPet {
                MyPetView(viewModel: .init(dataService: viewModel.dataService, pet: selectedPet))
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
