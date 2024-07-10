//
//  ManagePetView.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI

struct ManagePetView: View {
    
    @State var viewModel: ManagePetViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if viewModel.pet != nil {
                HStack {
                    Spacer()
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .asButton {
                             viewModel.deletePet()
                        }
                        .foregroundStyle(.appText)
                }
            }
            
            Spacer()
            
            HStack {
                Text("Name:")
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Species:")
                Picker("Species", selection: $viewModel.species) {
                    ForEach(Pet.Species.allCases) { species in
                        Text(species.rawValue)
                            .tag(species)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
            }
            
            Spacer()
            
            Text("Save")
                .multilineTextAlignment(.center)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(.red)
                .asButton {
                    viewModel.savePet()
                }
        }
        .padding()
    }
    
}

#Preview {
    ManagePetView(viewModel: .init(pet: nil))
}

#Preview {
    ManagePetView(viewModel: .init(pet: MockedData.pets.first!))
}
