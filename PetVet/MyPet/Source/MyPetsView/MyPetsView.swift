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
    @State var selectedTab: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.appPurpleGradient, .clear], startPoint: .top, endPoint: .bottom)
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.pets, content: petCell)
                }
                .padding()
            }
        }.ignoresSafeArea(edges: .bottom)
    }
    
    private func petCell(_ pet: Pet) -> some View {
        ZStack(alignment: .bottomTrailing) {
            if let image = pet.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
            } else {
                Image(pet.species.image)
            }
            LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
            
            Text(pet.name)
                .foregroundStyle(.white)
                .font(.title)
                .padding()
        }
        .frame(height: 200)
        .clipShape(.rect(cornerRadius: 20))
        .asButton {
            navigation.navigationPath.append(Navigation.MyPetsPath.pet(pet))
        }
    }
}


#Preview {
    let dataSource = DataSource()
    return MyPetsView(viewModel: .init(pets: MockedData.pets, dataSource: dataSource))
}
