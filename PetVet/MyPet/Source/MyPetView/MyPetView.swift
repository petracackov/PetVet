//
//  MyPetView.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI

struct MyPetView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: MyPetViewModel
    var pet: Pet { viewModel.pet }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                generalInfo()
                
                medicalRecords()
                
                events()
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 125)
        }
        .navigationDestination(for: Navigation.PetPath.self) { path in
            switch path {
            case .addMedicalRecord:
                ManageMedicalRecordView(viewModel: .init(dataSource: viewModel.dataSource,
                                                         pet: viewModel.pet))
            case .editPet:
                ManagePetView(viewModel: ManagePetViewModel(dataSource: viewModel.dataSource, pet: pet))
            case .medicalRecords:
                MedicalRecordsView(viewModel: .init(dataSource: viewModel.dataSource, pet: pet))
            case .reminders:
                Text("Reminders")
            }
        }
    }
    
    private func generalInfo() -> some View {
        Group {
            Image(uiImage: pet.image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipShape(.rect(cornerRadius: 10))
            
            HStack {
                Text(pet.name)
                    .font(.largeTitle)
                
                Spacer()
                
                
                Image.systemIconEdit
                    .resizable()
                    .frame(width: 24, height: 24)
                    .asButton {
                        navigation.navigationPath.append(Navigation.PetPath.editPet)
                    }
                    .foregroundStyle(.appText)
            }
            
            VStack(spacing: 10) {
                infoRow(title: "Date of birth", value: pet.birthDate.string)
                infoRow(title: "Gender", value: pet.gender.rawValue)
                infoRow(title: "Species", value: pet.species.rawValue)
            }
        }
    }
    
    private func medicalRecords() -> some View {
        Group {
            HStack(alignment: .center) {
                Text("Medical records")
                    .font(.largeTitle)
                Spacer()
                if viewModel.medicalRecords.isEmpty {
                    Image.systemIconPlus
                } else {
                    Image.systemIconChevronRight
                }
            }
            .foregroundStyle(.appText)
            .asButton {
                if viewModel.medicalRecords.isEmpty {
                    navigation.navigationPath.append(Navigation.PetPath.addMedicalRecord)
                } else {
                    navigation.navigationPath.append(Navigation.PetPath.medicalRecords)
                }
            }
            
            if viewModel.medicalRecords.isEmpty {
                HStack {

                    NoDataView(image: Image(systemName: "syringe.fill"), color: .appOrangeLight)
                    NoDataView(image: Image(systemName: "stethoscope"), color: .appOrangeLight)
                    NoDataView(image: Image(systemName: "pills.fill"), color: .appOrangeLight)

                }
                .frame(height: 120)
            } else {
                
                //First 3 events end then full separate screen
                VStack(spacing: 0) {
                    ForEach(viewModel.medicalRecords) { item in
                        MedicalRecordCell(title: item.title,
                                          date: item.date.string,
                                          description: item.itemDescription,
                                          isFirst: viewModel.isFirst(item),
                                          isLast: viewModel.isLast(item))
                        
                    }
                }
            }
            
        }
    }
    
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(value)
                .font(.body)
        }
    }
    
    private func events() -> some View {
        Group {
            HStack(alignment: .center) {
                Text("Events")
                    .font(.largeTitle)
                Spacer()
                Image.systemIconChevronRight
            }
            .foregroundStyle(.appText)
            .asButton {
                navigation.navigationPath.append(Navigation.PetPath.reminders)
            }
            
            HStack {

                NoDataView(image: Image(systemName: "bell.fill"))
                NoDataView(image: Image(systemName: "calendar"))
                NoDataView(image: Image(systemName: "clock.fill"))
                

            }
            .frame(height: 120)
            
        }
    }
}

#Preview {
    let dataSource = DataSource()
    return MyPetView(viewModel: .init(dataSource: dataSource,
                             pet: MockedData.pets.first!,
                             medicalRecords: Array(MockedData.medicalRecords.prefix(3))))
}

#Preview {
    let dataSource = DataSource()
    return MyPetView(viewModel: .init(dataSource: dataSource,
                             pet: MockedData.pets.first!,
                             medicalRecords: []))
}
