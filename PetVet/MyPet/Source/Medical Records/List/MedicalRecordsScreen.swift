//
//  MedicalRecordsScreen.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftUI

struct MedicalRecordsScreen: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: MedicalRecordsDataViewModel
    
    var body: some View {
        MedicalRecordsView(viewModel: viewModel)
            .navigationTitle("Medical record")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction) {
                    Image.systemIconPlus
                        .asButton {
                            navigation.navigationPath.append(Navigation.MedicalRecordsPath.addMedicalRecord)
                        }
                }
            })
            .navigationDestination(for: Navigation.MedicalRecordsPath.self, destination: { path in
                switch path {
                case .addMedicalRecord:
                    ManageMedicalRecordScreen(viewModel: .init(dataSource: viewModel.dataSource,
                                                               medicalRecord: nil,
                                                               pet: viewModel.pet))
                case .editMedicalRecord(let medicalRecord):
                    ManageMedicalRecordScreen(viewModel: .init(dataSource: viewModel.dataSource,
                                                               medicalRecord: medicalRecord,
                                                               pet: viewModel.pet))
                }
            })
    }
}
