//
//  MyPetsScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

struct MyPetsScreen: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: MyPetsDataViewModel
    
    var body: some View {
        if viewModel.pets.isEmpty {
            VStack {
                NoDataView()
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .foregroundStyle(.appPurple)
            }
            .asButton {
                navigation.navigationPath.append(Navigation.Path.managePet(nil))
            }
        } else if viewModel.pets.count == 1, let pet = viewModel.pets.first  {
            MyPetScreen(viewModel: .init(modelContext: viewModel.modelContext, pet: pet))
        } else {
            MyPetsView(viewModel: viewModel)
                .sheet(isPresented: $viewModel.managePetSheetIsShown, content: {
                    ManagePetView(viewModel: ManagePetDataViewModel(modelContext: viewModel.modelContext, pet: nil))
                })
        }
    }
}
