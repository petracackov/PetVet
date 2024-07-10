//
//  ManageMedicalRecordScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

struct ManageMedicalRecordScreen: View {
    
    @State var viewModel: ManageMedicalRecordDataViewModel
    
    var body: some View {
        ManageMedicalRecordView(viewModel: viewModel)
    }
}
