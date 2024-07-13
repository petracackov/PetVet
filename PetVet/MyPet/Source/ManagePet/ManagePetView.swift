//
//  ManagePetView.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI
import SwiftData

struct ManagePetView: View {
    
    @State var viewModel: ManagePetViewModel
    @State var isPresented = false
    @State var cameraSheetIsPresented = false
    @State var photoPickerIsShown = false
    
    var body: some View {
        VStack(alignment: .center) {
            if viewModel.isEditMode {
                HStack {
                    Spacer()
                    Image.systemIconTrash
                        .resizable()
                        .frame(width: 24, height: 24)
                        .asButton {
                             viewModel.deletePet()
                        }
                        .foregroundStyle(.appText)
                }
            }
            
            Spacer()
            
            HStack {
                Text("Name:")
                TextField("Name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Text("Species:")
                Picker("Species", selection: $viewModel.species) {
                    ForEach(Pet.Species.allCases) { species in
                        Text(species.rawValue)
                            .tag(species)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
            }
            
            ZStack {
                if let petImage = viewModel.image {
                    Image(uiImage: petImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                }
                Rectangle()
                    .foregroundStyle(.appPurpleLightDark.opacity(0.7))
                Image.systemIconCamera
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
            
            Spacer()
            
            Text("Save")
                .multilineTextAlignment(.center)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(.red)
                .asButton {
                    viewModel.savePet()
                }
        }
        .padding()
        .confirmationDialog("", isPresented: $isPresented, actions: {
            Text("Camera")
                .asButton {
                    cameraSheetIsPresented = true
                }
            
            Text("Photo library")
                .asButton {
                    photoPickerIsShown = true
                }
        })
        .photosPicker(isPresented: $photoPickerIsShown, selection: $viewModel.photoPickerItem, matching: .images)
        .fullScreenCover(isPresented: $cameraSheetIsPresented) {
            CameraView(selectedImage: $viewModel.image)
                .ignoresSafeArea()
        }
        .onChange(of: viewModel.photoPickerItem) { oldValue, newValue in
            guard let newValue else { return }
            viewModel.onImageSelected(newValue)
        }

    }
    
}

#Preview {
    let dataSource = DataSource()
    return ManagePetView(viewModel: .init(dataSource: dataSource, pet: nil))
}

#Preview {
    let data = DataSource()
    return ManagePetView(viewModel: ManagePetViewModel(dataSource: data, pet: MockedData.pets.first!))
}
