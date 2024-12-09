//
//  MyPetsView.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI

struct MyPetsView: View {
    
    @State var navigation = Navigation.shared
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
    
    @ViewBuilder
    private func petCell(_ pet: Pet) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 200)
            
            if viewModel.selectedPet != pet {
                ZStack(alignment: .bottomTrailing) {
                    Rectangle().foregroundStyle(.appGray3.opacity(0.2))
                    Image(uiImage: pet.image ?? UIImage(resource: pet.species.image))
                        .resizable()
                        .aspectRatio(contentMode: pet.image != nil ? .fill : .fit)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                    
                    LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                    
                    Text(pet.name)
                        .foregroundStyle(.appWhite)
                        .font(.largeTitle)
                        .padding()
                }
                .frame(height: 200)
                .clipShape(.rect(cornerRadius: 20))
                .asButton {
                    viewModel.selectedPet = pet
                }
            } else {
                Color.clear.frame(height: 200)
            }
        }
    }
}


#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    let pets = MockedData.pets
    return MyPetsView(viewModel: .init(pets: pets, dataService: dataService))
}
