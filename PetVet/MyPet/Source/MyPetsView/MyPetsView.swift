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
        VStack {
            ForEach(viewModel.pets, content: petCell)
            Spacer()
        }
    }
    
    private func petCell(_ pet: Pet) -> some View {
        HStack {
            Text(pet.name)
            Spacer()
        }
        .frame(height: 60)
        .asButton {
            navigation.navigationPath.append(Navigation.MyPetsPath.pet(pet))
        }
    }
}


#Preview {
    let dataSource = DataSource()
    return MyPetsView(viewModel: .init(pets: MockedData.pets, dataSource: dataSource))
}
