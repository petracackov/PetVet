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
            Rectangle()
                .plainList()
                .frame(height: 20)
                .foregroundStyle(.clear)
            ForEach(viewModel.medicalRecords) { item in
                MedicalRecordCell(title: item.title,
                                  date: item.date.string,
                                  description: item.itemDescription)
                .asButton {
                    navigation.navigationPath.append(Navigation.MedicalRecordsPath.editMedicalRecord(item))
                }
            }
            .onDelete(perform: viewModel.delete)
            .plainList()
            .padding(.horizontal, 20)
        }
        .environment(\.defaultMinListRowHeight, 0)
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
        .appAlert(error: viewModel.error, isPresented: $viewModel.alertIsShown)
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
                                               pet: MockedData.pets[0]))
}

#Preview("No data") {
    let dataService = DataService(dataSource: DataSource.shared)
    return MedicalRecordsView(viewModel: .init(dataService: dataService,
                                               medicalRecords: [],
                                               pet: MockedData.pets.first!))
}
