//
//  MedicalRecordsView.swift
//  MyPet
//
//  Created by Petra Cackov on 2. 7. 24.
//

import SwiftUI

struct MedicalRecordsView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: MedicalRecordsViewModel
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.medicalRecords) { medicalRecord in
                    Text(medicalRecord.title)
                        .asButton {
                            navigation.navigationPath.append(Navigation.MedicalRecordsPath.editMedicalRecord(medicalRecord))
                        }
                }
                .onDelete(perform: viewModel.delete)
            }
        }
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
                ManageMedicalRecordView(viewModel: .init(dataSource: viewModel.dataSource,
                                                           medicalRecord: nil,
                                                           pet: viewModel.pet))
            case .editMedicalRecord(let medicalRecord):
                ManageMedicalRecordView(viewModel: .init(dataSource: viewModel.dataSource,
                                                           medicalRecord: medicalRecord,
                                                           pet: viewModel.pet))
            }
        })
    }
    
}

#Preview {
    let dataSource = DataSource()
    return MedicalRecordsView(viewModel: .init(dataSource: dataSource,
                                               medicalRecords: MockedData.medicalRecords,
                                               pet: MockedData.pets.first!))
}
