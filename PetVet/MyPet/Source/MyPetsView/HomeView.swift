//
//  HomeView.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: MyPetsViewModel
    
    var body: some View {
        ZStack {
            if viewModel.pets.isEmpty {
                NoDataView(.generic) {
                    navigation.navigationPath.append(Navigation.MyPetsPath.createNewPet)
                }
            } else if viewModel.pets.count == 1, let pet = viewModel.pets.first  {
                MyPetView(viewModel: .init(dataService: viewModel.dataService, pet: pet))
            } else {
                MyPetsView(viewModel: viewModel)
            }
            
            if let selectedPet = viewModel.selectedPet {
                MyPetView(viewModel: .init(dataService: viewModel.dataService, pet: selectedPet))
                    .navigationTitle("")
                    .toolbarItem(.systemIconChevronLeft, placement: .navigation) {
                        viewModel.selectedPet = nil
                    }
            }
        }
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
