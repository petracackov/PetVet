//
//  PetCarouselView.swift
//  PetVet
//
//  Created by Petra Cackov on 28/05/2022.
//

import SwiftUI

struct PetCarouselView: View {

    var pets: [Pet] = []

    private let spacing: CGFloat = 16
    private let horizontalInsets: CGFloat = 40
    private let bottomInset: CGFloat = 0
    private let topInset: CGFloat = 0
    @State var selectedIndex: Int = 0
    @State var isShowingDetails: Bool = true

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                GeometryReader { proxy in
                    CarouselView(currentIndex: $selectedIndex,
                                 items: pets,
                                 spacing: spacing,
                                 topInset: topInset,
                                 bottomInset: bottomInset,
                                 leadingInset: horizontalInsets,
                                 trailingInset: horizontalInsets) { pet in

                        PetCardView(pet: pet, isShowingDetails: $isShowingDetails)
                        .frame(width: proxy.size.width - horizontalInsets*2,
                               height: proxy.size.height - bottomInset - topInset)
                    }
                }
                if isShowingDetails {
                    PetDetailsView(pet: pets[selectedIndex])
                        .frame(height: 3*proxy.size.height/4)
                        .transition(.move(edge: .bottom))

                }
            }
            .padding(.bottom, 40)
        }
    }
}

struct PetCarouselView_Previews: PreviewProvider {
    static private let pets: [Pet] = [
        .init(name: "Nacho1", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .cat),
        .init(name: "Nacho2", ownerId: "nacho", gender: .female, dateOfBirth: Date(), type: .cat),
            .init(name: "Nach3o", ownerId: "nacho", gender: .male, dateOfBirth: Date(), type: .other)]
    static var previews: some View {
        PetCarouselView(pets: pets)
    }
}
