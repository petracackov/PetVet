//
//  PetProfileView.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import SwiftUI

struct PetProfileView: View {

    private var viewModel = PetProfileVM()

    var body: some View {
        ZStack(alignment: .center) {

            BackgroundView(color: .ui.background)

            if viewModel.pets.isEmpty {
                showNoPetsView()
            } else {
                showPetProfile()
            }
        }
    }

    private func showPetProfile() -> some View {
        return ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ProfileHeaderView()
            }

        }.padding()
    }

    private func showNoPetsView() -> some View {
        return ProfileHeaderView(title: "You have no pets yet").edgesIgnoringSafeArea(.all)
    }

}

struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView()
    }
}
