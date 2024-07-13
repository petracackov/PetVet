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
        VStack {
            Spacer()
            
            TextField("Title", text: $viewModel.title)
                .textFieldStyle(.roundedBorder)
            TextField("Description", text: $viewModel.description)
                .textFieldStyle(.roundedBorder)
            DatePicker("Date", selection: $viewModel.date, displayedComponents: [.date])
                .datePickerStyle(.compact)
            Spacer()
            
            Text("Save")
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(.red)
                .asButton {
                    viewModel.save()
                }
        }
        .padding()
    }
}

#Preview {
    let dataSource = DataSource()
    return ManageMedicalRecordView(viewModel: .init(dataSource: dataSource,
                                             medicalRecord: nil,
                                             pet: MockedData.pets.first!))
}
