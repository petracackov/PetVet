//
//  ManageMedicalRecordView.swift
//  MyPet
//
//  Created by Petra Cackov on 5. 7. 24.
//

import SwiftUI

struct ManageMedicalRecordView: View {
    
    @State var viewModel: ManageMedicalRecordViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            AppTextField(text: $viewModel.title, title: "Title")
            AppTextField(text: $viewModel.description, title: "Description")
            
            AppDatePicker(date: $viewModel.date, title: "Date:", components: .date)
                .padding(.top, 20)
            Spacer()
            
            AppButton(title: "Save") {
                viewModel.save()
            }

        }
        .padding()
        .appGradient()
        .toolbarItem(.systemIconTrash, isVisible: viewModel.isEditing) {
            viewModel.deleteMedicalRecord()
        }
    }
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return ManageMedicalRecordView(viewModel: .init(dataService: dataService,
                                             medicalRecord: nil,
                                             pet: MockedData.pets.first!))
}
