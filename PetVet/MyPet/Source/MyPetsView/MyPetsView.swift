//
//  MyPetsView.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI

struct MyPetsView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: MyPetsViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.pets, content: petCell)
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .appGradient()
    }
    
    private func petCell(_ pet: Pet) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: pet.image ?? UIImage(resource: pet.species.image))
                .resizable()
                .scaledToFill()
                .frame(height: 200)
            
            LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
            
            Text(pet.name)
                .foregroundStyle(.white)
                .font(.title)
                .padding()
        }
        .frame(height: 200)
        .clipShape(.rect(cornerRadius: 20))
        .asButton {
            //navigation.navigationPath.append(Navigation.MyPetsPath.pet(pet))
            viewModel.selectedPet = pet
        }
    }
}


#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return MyPetsView(viewModel: .init(pets: MockedData.pets, dataService: dataService))
}
