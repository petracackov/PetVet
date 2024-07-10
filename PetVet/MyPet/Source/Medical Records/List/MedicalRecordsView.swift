//
//  MedicalRecordsView.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftUI

struct MedicalRecordsView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: MedicalRecordsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.medicalRecords) { item in
                Text(item.title)
                    .asButton {
                        navigation.navigationPath.append(Navigation.Path.manageMedicalRecord(medicalRecord: item, pet: viewModel.pet))
                    }
            }
            .onDelete(perform: viewModel.delete)
        }
    }
    
}

#Preview {
    MedicalRecordsView(viewModel: .init(medicalRecords: MockedData.medicalRecords, pet: MockedData.pets.first!))
}
