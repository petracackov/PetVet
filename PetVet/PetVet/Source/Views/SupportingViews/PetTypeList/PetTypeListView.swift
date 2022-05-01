//
//  PetTypeListView.swift
//  PetVet
//
//  Created by Petra Cackov on 24/04/2022.
//

import SwiftUI

struct PetTypeListView: View {

    @Binding var selectedPet: Pet.PetType

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Pet.PetType.allCases) { pet in
                    PetTypeView(pet: pet, isSelected: selectedPet == pet) { pet in
                        guard selectedPet != pet else { return }
                        self.selectedPet = pet
                    }
                }
            }.padding([.leading, .trailing])
        }
    }
}

struct PetTypeListView_Previews: PreviewProvider {
    @State static var pet: Pet.PetType = .cat
    static var previews: some View {
        PetTypeListView(selectedPet: $pet)
    }
}
