//
//  PetView.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftUI

struct PetView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: MyPetViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                generalInfo()
                
                medicalRecords()
                
                HStack(alignment: .center) {
                    Text("Events")
                        .font(.largeTitle)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.appText)
                .asButton {
                    navigation.navigationPath.append(Navigation.PetPath.reminders)
                    
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 125)
        }
    }
    
    private func generalInfo() -> some View {
        Group {
            Image(.nacho)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipShape(.rect(cornerRadius: 10))
            
            HStack {
                Text(viewModel.pet.name)
                    .font(.largeTitle)
                
                Spacer()
                
                
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .asButton {
                        navigation.navigationPath.append(Navigation.PetPath.editPet)
                    }
                    .foregroundStyle(.appText)
            }
            
            VStack(spacing: 10) {
                infoRow(title: "Date of birth", value: "19.2.1994")
                infoRow(title: "Gender", value: "male")
                infoRow(title: "Species", value: viewModel.pet.species.rawValue)
            }
        }
    }
    
    private func medicalRecords() -> some View {
        Group {
            HStack(alignment: .center) {
                Text("Medical records")
                    .font(.largeTitle)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .foregroundStyle(.appText)
            .asButton {
                navigation.navigationPath.append(Navigation.PetPath.medicalRecords)
            }
            
            //First 3 events end then full separate screen
            VStack(spacing: 20) {
                ForEach(viewModel.medicalRecords) { item in
                    VStack(alignment: .leading, spacing: 20) {
                        Group {
                            HStack {
                                Text(item.title)
                                    .font(.title2)
                                    .foregroundStyle(.appBlackWhite)
                                Spacer()
                                Text(item.date.string)
                                    .font(.body)
                                    .foregroundStyle(.appBlackWhite)
                            }
                            Text(item.itemDescription)
                                .font(.subheadline)
                                .foregroundStyle(.appBlackWhite)
                        }
                        .padding(.horizontal, 10)
                        
                        if !viewModel.medicalRecords.isLast(element: item) {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundStyle(.appBlackWhite)
                        }
                    }
                }
            }
            .padding(20)
            .background(.appGray3.opacity(0.2))
            .clipShape(.rect(cornerRadius: 15))
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
}

#Preview {
    PetView(viewModel: .init(pet: MockedData.pets.first!,
                             medicalRecords: Array(MockedData.medicalRecords.prefix(3))))
}
