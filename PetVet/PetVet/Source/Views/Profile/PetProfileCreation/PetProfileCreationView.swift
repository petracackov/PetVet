//
//  PetProfileCreationView.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI

struct PetProfileCreationView: View {

    @State var petName: String = ""
    @State var transponderCode: String = "12345678"
    @State var transponderCodeLocation: String = "Neck"
    @State var datePickerIsOpened: Bool = false
    @State var selectedGender: Int = 0
    @State var selectedDate: Date = Date()
    @State var selectedImage: UIImage?
    @State var imagePickerIsShown: Bool = false

    @ObservedObject var viewModel = PetProfileCreationVM()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {

                CustomTextFieldView(title: "Name", text: $petName)

                genderSelectionView()

                DateSelectionView(selectedDate: $selectedDate, pickerIsShown: $datePickerIsOpened)

                profileImage()

                transponderCodeView()

                CustomTextFieldView(title: "Transponder Location", text: $transponderCodeLocation)

                CustomButtonView(title: viewModel.buttonTitle) {
                    viewModel.createPet()
                    // pop on success
                }
            }
            .padding()
            .sheet(isPresented: $imagePickerIsShown) {
                ImagePicker(image: $selectedImage)
            }
        }
    }

    private func genderSelectionView() -> some View {
        HStack() {
            Text("Gender:")
                .titleStyle()
            SegmentedControlView(
                items: PetProfileCreationVM.Gender.allCases.map{ $0.rawValue },
                selectedIndex: $selectedGender)
        }
    }

    private func profileImage() -> some View {
        VStack(alignment: .leading) {
            Text("Image:")
                .titleStyle()
            ZStack {
                Image(uiImage: selectedImage ?? UIImage())
                    .resizable()
                    .background(Color.ui.purple)
                    .opacity(0.5)

                Button {
                    imagePickerIsShown = true
                } label: {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.5)
                        .foregroundColor(Color.ui.white)
                        .padding(30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(width: 130, height: 130)
            .contentShape(Circle())
            .clipShape(Circle())
        }
    }

    private func transponderCodeView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Transponder code:")
                .titleStyle()
            BarcodeView(barcode: "123456789")
                .frame(height: 130)
                .border(Color.ui.borderGray, width: 2)

            LineTextFieldView(text: $transponderCode)

        }
    }

    private func closePicker() {
        withAnimation(Animation.spring()) {
            datePickerIsOpened = false
        }
    }
}

struct PetProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PetProfileCreationView()
            PetProfileCreationView().preferredColorScheme(.dark)
        }

    }
}
