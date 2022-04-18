//
//  PetProfileCreationView.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI

struct PetProfileCreationView: View {

    @State var petName: String = ""
    @State var datePickerIsOpened: Bool = false
    @ObservedObject var viewModel = PetProfileCreationVM()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {

                CustomTextFieldView(title: "Name", text: $petName)

                HStack() {
                    Text("Gender:")
                        .titleStyle()
                    SegmentedControlView(
                        items: PetProfileCreationVM.Gender.allCases.map{ $0.rawValue },
                        selectedIndex: $viewModel.selectedGender)
                }

                DateSelectionView(selectedDate: $viewModel.selectedDate, pickerIsShown: $datePickerIsOpened)
                profileImage()
                transponderCode()


            }
            .padding()
        }
    }

    private func profileImage() -> some View {
        VStack(alignment: .leading) {
            Text("Image:")
                .titleStyle()
            Circle().frame(width: 130, height: 130)
        }
    }

    private func transponderCode() -> some View {
        VStack(alignment: .leading) {
            Text("Transponder code:")
                .titleStyle()
            BarcodeView(barcode: "123456789")
                .frame(height: 130)
                .border(Color.ui.borderGray, width: 2)

            Text("12345678902345").frame(width: .infinity)
            Rectangle().frame(height: 3)
            Text("Transponder location:")
                .titleStyle()
            Text("Neck")
            Rectangle().frame(height: 3)
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
