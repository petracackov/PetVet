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
                MedicalRecordCell(title: item.title,
                                  date: item.date.string,
                                  description: item.itemDescription,
                                  isFirst: viewModel.medicalRecords.isFirst(item),
                                  isLast: viewModel.medicalRecords.isLast(item))
                .asButton {
                    navigation.navigationPath.append(Navigation.MedicalRecordsPath.editMedicalRecord(item))
                }
            }
            .onDelete(perform: viewModel.delete)
            .plainList()
            .padding(.horizontal, 20)
        }
        .overlay {
            if viewModel.medicalRecords.isEmpty {
                NoDataView(.medicalRecords)
                    .padding(20)
            }
        }
        .listStyle(.plain)
        .background(.appBackground)
        .navigationTitle("Medical record")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarItem(.systemIconPlus, action: {
            navigation.navigationPath.append(Navigation.MedicalRecordsPath.addMedicalRecord)
        })
        .toolbarItem(.systemIconChevronLeft, placement: .navigation) {
            navigation.navigationPath.removeLast()
        }
        .navigationDestination(for: Navigation.MedicalRecordsPath.self, destination: { path in
            switch path {
            case .addMedicalRecord:
                ManageMedicalRecordView(viewModel: .init(dataService: viewModel.dataService,
                                                           pet: viewModel.pet))
            case .editMedicalRecord(let medicalRecord):
                ManageMedicalRecordView(viewModel: .init(dataService: viewModel.dataService,
                                                           medicalRecord: medicalRecord,
                                                           pet: viewModel.pet))
            }
        })
    }
    
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return MedicalRecordsView(viewModel: .init(dataService: dataService,
                                               medicalRecords: MockedData.medicalRecords,
                                               pet: MockedData.pets.first!))
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return MedicalRecordsView(viewModel: .init(dataService: dataService,
                                               medicalRecords: [],
                                               pet: MockedData.pets.first!))
}
