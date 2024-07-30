//
//  MyPetView.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI

struct MyPetView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: MyPetViewModel
    private var pet: Pet { viewModel.pet }
    var namespace: Namespace.ID? = nil
    
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
        .background(.appBackground)
        .navigationTitle("My Pet")
        .toolbarItem(SystemIcon.systemIconEdit, action: {
            navigation.navigationPath.append(Navigation.PetPath.editPet)
        })
        .navigationDestination(for: Navigation.PetPath.self) { path in
            switch path {
            case .addReminder:
                ManageEventsView(viewModel: .init(dataService: viewModel.dataService, petInfo: .init(pet: viewModel.pet)))
            case .addMedicalRecord:
                ManageMedicalRecordView(viewModel: .init(dataService: viewModel.dataService,
                                                         pet: viewModel.pet))
            case .editPet:
                ManagePetView(viewModel: ManagePetViewModel(dataService: viewModel.dataService, pet: pet))
            case .medicalRecords:
                MedicalRecordsView(viewModel: .init(dataService: viewModel.dataService, pet: pet))
            case .reminders:
                EventsView(viewModel: .init(dataService: viewModel.dataService, pet: viewModel.pet))
            }
        }
    }
    
    private func generalInfo() -> some View {
        Group {
            ZStack {
                Rectangle().foregroundStyle(.appGray3.opacity(0.2))
                Image(uiImage: pet.image ?? UIImage(resource: pet.species.image))
                    .resizable()
                    .aspectRatio(contentMode: pet.image != nil ? .fill : .fit)
                    .frame(height: 200)
                    
            }
            .clipShape(.rect(cornerRadius: 10))
            .globalElementId(pet.id, item: "image", namespace: namespace)
            HStack {
                Text(pet.name)
                    .font(.largeTitle)
                    .foregroundStyle(.appText)
                    .globalElementId(pet.id, item: "name", namespace: namespace)
                
                Spacer()
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
                    SystemIcon.systemIconPlus.image
                } else {
                    SystemIcon.systemIconChevronRight.image
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
                NoDataView(.medicalRecords)
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
                
                if viewModel.events.isEmpty {
                    SystemIcon.systemIconPlus.image
                } else {
                    SystemIcon.systemIconChevronRight.image
                }
            }
            .foregroundStyle(.appText)
            .asButton {
                if viewModel.events.isEmpty {
                    navigation.navigationPath.append(Navigation.PetPath.addReminder)
                } else {
                    navigation.navigationPath.append(Navigation.PetPath.reminders)
                }
            }
            
            if viewModel.events.isEmpty {
                NoDataView(.events)
                    .frame(height: 120)
            } else {
                VStack(spacing: 0) {
                    ForEach(viewModel.events) { event in
                        EventCell(event: event,
                                  isLast: viewModel.events.isLast(event),
                                  isFirst: viewModel.events.isFirst(event),
                                  showPet: false)
                    }
                }
            }
            
        }
    }
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return MyPetView(viewModel: .init(dataService: dataService,
                             pet: MockedData.pets[1],
                                      medicalRecords: Array(MockedData.medicalRecords.prefix(3)),
                                      events: Array(MockedData.events.prefix(3))))
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    let pet = MockedData.pets[0]
    dataService.dataSource.modelContext.insert(pet)
    return MyPetView(viewModel: .init(dataService: dataService,
                                      pet: pet,
                                      medicalRecords: [],
                                      events: []))
}
