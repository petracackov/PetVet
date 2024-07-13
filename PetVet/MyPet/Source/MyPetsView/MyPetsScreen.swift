//
//  MyPetsScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

struct MyPetsScreen: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: MyPetsDataViewModel
    
    var body: some View {
        Group {
            if viewModel.pets.isEmpty {
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
                
            } else if viewModel.pets.count == 1, let pet = viewModel.pets.first  {
                MyPetScreen(viewModel: .init(dataSource: viewModel.dataSource, pet: pet))
            } else {
                MyPetsView(viewModel: viewModel)
            }
        }
        .navigationDestination(for: Navigation.MyPetsPath.self, destination: { path in
            switch path {
            case .pet(let pet):
                MyPetScreen(viewModel: .init(dataSource: viewModel.dataSource, pet: pet))
            case .createNewPet:
                ManagePetView(viewModel: ManagePetDataViewModel(dataSource: viewModel.dataSource, pet: nil))
            }
            
        })
    }
}
