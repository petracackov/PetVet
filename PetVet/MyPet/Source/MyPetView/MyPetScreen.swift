//
//  MyPetScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI

struct MyPetScreen: View {
    
    @State var viewModel: MyPetDataViewModel
    
    var body: some View {
        PetView(viewModel: viewModel)
    }
    
    
}
