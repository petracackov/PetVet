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
                noDataView()
            } else if viewModel.pets.count == 1, let pet = viewModel.pets.first  {
                MyPetView(viewModel: .init(dataSource: viewModel.dataSource, pet: pet))
            } else {
                MyPetsView(viewModel: viewModel)
            }
        }
        .navigationDestination(for: Navigation.MyPetsPath.self, destination: { path in
            switch path {
            case .pet(let pet):
                MyPetView(viewModel: .init(dataSource: viewModel.dataSource, pet: pet))
            case .createNewPet:
                ManagePetView(viewModel: ManagePetViewModel(dataSource: viewModel.dataSource, pet: nil))
            }
            
        })
        
    }
    
    private func noDataView() -> some View {
        VStack {
            NoDataView()
            Image.systemIconPlus
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFit()
                .foregroundStyle(.appPurple)
        }
        .asButton {
            navigation.navigationPath.append(Navigation.MyPetsPath.createNewPet)
        }
    }
}
