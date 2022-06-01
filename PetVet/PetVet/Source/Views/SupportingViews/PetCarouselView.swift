//
//  PetCarouselView.swift
//  PetVet
//
//  Created by Petra Cackov on 28/05/2022.
//

import SwiftUI

struct PetCarouselView: View {

    var pets: [Pet] = []

    private let spacing: CGFloat = 20
    private let horizontalInsets: CGFloat = 40
    private let bottomInset: CGFloat = 40
    private let topInset: CGFloat = 5
    @State var selectedIndex: Int = 0

    var body: some View {
        GeometryReader { proxy in
            CarouselView(currentIndex: $selectedIndex,
                         items: pets,
                         spacing: spacing,
                         topInset: topInset,
                         bottomInset: bottomInset,
                         leadingInset: horizontalInsets,
                         trailingInset: horizontalInsets) { pet in

                ZStack {
                    BackgroundView(color: .pink)
                    Text(pet.name ?? "")
                }
                .frame(width: proxy.size.width - horizontalInsets*2,
                       height: proxy.size.height - bottomInset - topInset)
                .cornerRadius(20)
            }
        }
    }
}

struct PetCarouselView_Previews: PreviewProvider {
    static private let pets: [Pet] = [
        .init(name: "Nacho", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .cat),
        .init(name: "Nacho", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .cat),
            .init(name: "Nacho", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .cat)]
    static var previews: some View {
        PetCarouselView(pets: pets)
    }
}
