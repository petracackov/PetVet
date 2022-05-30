//
//  PetListView.swift
//  PetVet
//
//  Created by Petra Cackov on 15/05/2022.
//

import SwiftUI

struct PetListView: View {

    var pets: [Pet]
    var rows = [
        GridItem(.flexible())
    ]

    @State var screenSize: CGSize = .zero
    var cardSize: CGSize {
        CGSize(width: screenSize.width - padding*2, height: (screenSize.width - padding*2)*1.5)
    }

    let cardSpacing: CGFloat = 20
    var padding: CGFloat { cardSpacing*2 }

    var body: some View {
        GeometryReader { proxy in

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: cardSpacing) {
                    ForEach(pets) { pet in
                        ZStack {
                            BackgroundView(color: .ui.purple)
                                .frame(width: cardSize.width, height: cardSize.height)
                                .cornerRadius(50)
                        }

                    }
                }
                .padding([.leading, .top, .bottom, .trailing], padding)
            }


        }
        .getSize($screenSize)
    }
}

struct PetListView_Previews: PreviewProvider {
    static private let pets: [Pet] = [
        .init(name: "Nacho", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .cat),
        .init(name: "Nacho", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .cat),
            .init(name: "Nacho", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .cat)]
    static var previews: some View {
        PetListView(pets: pets)
    }
}
