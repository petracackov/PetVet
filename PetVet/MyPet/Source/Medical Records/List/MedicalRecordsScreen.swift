//
//  MedicalRecordsScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftUI

struct MedicalRecordsScreen: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: MedicalRecordsDataViewModel
    
    var body: some View {
        MedicalRecordsView(viewModel: viewModel)
            .navigationTitle("Medical record")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction) {
                    Image(systemName: "plus")
                        .asButton {
                            navigation.navigationPath.append(Navigation.MedicalRecordsPath.addMedicalRecord)
                        }
                }
            })
            .navigationDestination(for: Navigation.MedicalRecordsPath.self, destination: { path in
                switch path {
                case .addMedicalRecord:
                    ManageMedicalRecordScreen(viewModel: .init(modelContext: viewModel.modelContext,
                                                               medicalRecord: nil,
                                                               pet: viewModel.pet))
                case .editMedicalRecord(let medicalRecord):
                    ManageMedicalRecordScreen(viewModel: .init(modelContext: viewModel.modelContext,
                                                               medicalRecord: medicalRecord,
                                                               pet: viewModel.pet))
                }
            })
    }
}
