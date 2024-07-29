//
//  ManagePetView.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI
import SwiftData
import _PhotosUI_SwiftUI

struct ManagePetView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: ManagePetViewModel
    @State var isPresented = false
    @State var cameraSheetIsPresented = false
    @State var photoPickerIsShown = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    
                    AppTextField(text: $viewModel.name, title: "Name")
                    
                    speciesPicker()
                    
                    genderPicker()
                    
                    datePicker()
                    
                    imageSelector()
                }
            }
            
            Spacer()
            AppButton(title: "Save", action: viewModel.savePet)
                .padding(.bottom)
        }
        .background(.clear)
        .padding(.horizontal)
        .navigationTitle(viewModel.isEditMode ? "Edit your pet" : "Create your pet")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarItem(.systemIconTrash, isVisible: viewModel.isEditMode, action: {
            viewModel.deletePet()
        })
        .toolbarItem(.systemIconChevronLeft, placement: .navigation) {
            navigation.navigationPath.removeLast()
        }
        .confirmationDialog("", isPresented: $isPresented, actions: {
            if viewModel.cameraAccessGranted {
                Text("Camera")
                    .asButton {
                        cameraSheetIsPresented = true
                    }
            }
            
            Text("Photo library")
                .asButton {
                    photoPickerIsShown = true
                }
        })
        .photosPicker(isPresented:  $photoPickerIsShown, selection: $viewModel.photoPickerItem, matching: .images)
        .fullScreenCover(isPresented: $cameraSheetIsPresented) {
            CameraView(selectedImage: $viewModel.image)
                .ignoresSafeArea()
        }
        .onChange(of: viewModel.photoPickerItem) { oldValue, newValue in
            guard let newValue else { return }
            viewModel.onImageSelected(newValue)
        }

    }
    
    private func datePicker() -> some View {
        HStack {
            Text("Birth date:")
                .font(.body)
                .foregroundStyle(.appGray1)
            DatePicker(selection: $viewModel.date, displayedComponents: .date) {
                Text("")
            }
            Spacer()
        }
    }
    
    private func genderPicker() -> some View {
        HStack {
            Text("Gender:")
                .font(.body)
                .foregroundStyle(.appGray1)
            Picker("Gender", selection: $viewModel.gender) {
                ForEach(Pet.Gender.allCases) { gender in
                    Text(gender.rawValue)
                        .tag(gender)
                }
            }
            .pickerStyle(.segmented)
            .foregroundStyle(.red)
            .colorMultiply(.appPurpleLight)
            
            Spacer()
        }

    }
    
    private func imageSelector() -> some View {
        ZStack {
            if let petImage = viewModel.image {
                Image(uiImage: petImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .allowsHitTesting(false) // otherwise the image (or rather its frame) goes over content
                    
            }
            Rectangle()
                .foregroundStyle(.appPurpleLightDark.opacity(0.7))
            SystemIcon.systemIconCamera.image
                .resizable()
                .scaledToFit()
                .scaleEffect(CGSize(width: 0.6, height: 0.6))
                .foregroundStyle(.appWhite)
        }
        .frame(height: 200)
        .clipShape(.rect(cornerRadius: 20))
        .asButton {
            isPresented = true
        }
    }
    
    private func speciesPicker() -> some View {
        HStack {
            Text("Species:")
                .font(.body)
                .foregroundStyle(.appGray1)
            Picker("Species", selection: $viewModel.species) {
                ForEach(Pet.Species.allCases) { species in
                    Text(species.rawValue)
                        .tag(species)
                }
            }
            .pickerStyle(.menu)
            .tint(.appPurple)
            Spacer()
        }
    }
    
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return ManagePetView(viewModel: .init(dataService: dataService, pet: nil))
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return ManagePetView(viewModel: ManagePetViewModel(dataService: dataService, pet: MockedData.pets.first!))
}
