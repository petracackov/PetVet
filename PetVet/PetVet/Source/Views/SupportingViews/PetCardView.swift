//
//  PetCardView.swift
//  PetVet
//
//  Created by Petra Cackov on 02/06/2022.
//

import SwiftUI

struct PetCardView: View {

    let pet: Pet

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                BackgroundView(color: .ui.purple)

                VStack {
                    Image(uiImage: pet.typeUi.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    Spacer()
                    HStack {
                        Text(pet.name ?? "")
                            .multilineTextAlignment(.leading)
                            .font(.ui.arialFont(withSize: 40))
                            .foregroundColor(.ui.white)
                        Spacer()
                    }


                }

                .padding(EdgeInsets(top: 80, leading: 20, bottom: 40, trailing: 20))
    //            .frame(maxWidth: .infinity)

            }
            .cornerRadius(20)
        }
    }
}

struct PetCardView_Previews: PreviewProvider {
    static private let pet = Pet(name: "Nacho", ownerId: "1234", gender: .male, dateOfBirth: Date(), type: .cat)
    static var previews: some View {
        PetCardView(pet: pet)
    }
}
