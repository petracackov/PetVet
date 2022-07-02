//
//  PetCardView.swift
//  PetVet
//
//  Created by Petra Cackov on 02/06/2022.
//

import SwiftUI

struct PetCardView: View {

    let pet: Pet
    @Binding var isShowingDetails: Bool

    var body: some View {
        ZStack {
            BackgroundView(color: .ui.purple)

            Image(uiImage: pet.typeUi.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Spacer()
                
                HStack {
                    Text(pet.name ?? "")
                        .multilineTextAlignment(.leading)
                        .font(.ui.arialFont(withSize: 40))
                        .foregroundColor(.ui.white)
                    Spacer()
                }

                Button {
                    withAnimation {
                        isShowingDetails.toggle()
                    }
                } label: {
                    if isShowingDetails {
                        Text("˄")
                            .frame(maxWidth: .infinity)
                            .font(.ui.arialFont(withSize: 40))
                            .foregroundColor(.ui.white)

                    } else {
                        Text("⌄")
                            .frame(maxWidth: .infinity)
                            .font(.ui.arialFont(withSize: 40))
                            .foregroundColor(.ui.white)

                    }
                }
                .frame(maxWidth: .infinity)


            }

            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))

        }
        .cornerRadius(20)
    }
}

struct PetCardView_Previews: PreviewProvider {
    static private let pet = Pet(name: "Nacho", ownerId: "1234", gender: .male, dateOfBirth: Date(), type: .cat)
    @State static var showDetails: Bool = false
    static var previews: some View {
        PetCardView(pet: pet, isShowingDetails: $showDetails)
    }
}
