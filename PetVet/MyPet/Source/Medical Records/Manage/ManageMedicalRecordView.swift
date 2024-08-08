//
//  ManageMedicalRecordView.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

struct ManageMedicalRecordView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: ManageMedicalRecordViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    AppTextField(text: $viewModel.title, title: "Title")
                    AppTextField(text: $viewModel.description, title: "Description")
                    
                    AppDatePicker(date: $viewModel.date, title: "Date:", components: .date)
                        .padding(.top, 20)
                }
            }
            AppButton(title: "Save") {
                viewModel.save()
            }
        }
        .padding()
        .appGradient()
        .appAlert(error: viewModel.error, isPresented: $viewModel.alertIsShown)
        .navigationTitle(viewModel.isEditing ? "Edit medical record" : "Create medical record")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarItem(.systemIconTrash, isVisible: viewModel.isEditing) {
            viewModel.deleteMedicalRecord()
        }
        .toolbarItem(.systemIconChevronLeft, placement: .navigation) {
            navigation.navigationPath.removeLast()
        }
    }
    
}

#Preview("Create new") {
    let dataService = DataService(dataSource: DataSource.shared)
    return ManageMedicalRecordView(viewModel: .init(dataService: dataService,
                                             medicalRecord: nil,
                                             pet: MockedData.pets[0]))
}

#Preview("Edit") {
    let dataService = DataService(dataSource: DataSource.shared)
    return ManageMedicalRecordView(viewModel: .init(dataService: dataService,
                                                    medicalRecord: MockedData.medicalRecords[0],
                                             pet: MockedData.pets[0]))
}
