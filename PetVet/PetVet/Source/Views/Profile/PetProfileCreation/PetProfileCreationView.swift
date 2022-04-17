//
//  PetProfileCreationView.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI

struct PetProfileCreationView: View {

    @State var petName: String = ""
    @ObservedObject var viewModel = PetProfileCreationVM()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CustomTextFieldView(title: "Name", text: $petName)
                Spacer(minLength: 20)
                HStack() {
                    Text("Gender:")
                        .titleStyle()
                    SegmentedControlView(
                        items: PetProfileCreationVM.Gender.allCases.map{ $0.rawValue },
                        selectedIndex: $viewModel.selectedGender)
                }
            }
        }
    }
}

struct PetProfileCreationView_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileCreationView()
    }
}
