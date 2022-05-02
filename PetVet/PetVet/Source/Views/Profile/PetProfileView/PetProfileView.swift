//
//  PetProfileView.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import SwiftUI

struct PetProfileView: View {

    private var viewModel: PetProfileVM
    @State var showDetails: Bool = false

    init(pet: Pet?) {
        self.viewModel = PetProfileVM(pet: pet)
    }

    var body: some View {
        ZStack(alignment: .center) {
            if let pet = viewModel.pet {
                NavigationLink(
                    destination: PetDetailsView(pet: pet),
                    isActive: $showDetails
                ) {
                   EmptyView()
                }
            }

            BackgroundView(color: .ui.background)

            if let pet = viewModel.pet {
                showPetProfile(pet)
            } else {
                showNoPetsView()
            }
        }
    }

    private func showPetProfile(_ pet: Pet) -> some View {
        return ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProfileHeaderView(title: pet.name, leftIcon: pet.typeUi.emoji, rightIcon: pet.genderUi.emoji) {
                    showDetails = true
                }
            }
        }.padding()
    }

    private func showNoPetsView() -> some View {
        return ProfileHeaderView(title: "You have no pets yet").edgesIgnoringSafeArea(.all)
    }

}

struct PetProfileView_Previews: PreviewProvider {
    static let pet = Pet(name: "Test pet", ownerId: "OwnerId", gender: .male, dateOfBirth: Date(), type: .cat)
    static var previews: some View {
        Group {
            PetProfileView(pet: pet)
            PetProfileView(pet: pet).preferredColorScheme(.dark)
            PetProfileView(pet: nil)
        }

    }
}
