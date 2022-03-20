//
//  CustomNavigationButton.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct CustomNavigationButton<Destination: View>: View {

    var buttonTitle: String
    @ViewBuilder var destination: Destination
    @State private var isActive: Bool = false

    var body: some View {
        NavigationLink(
            destination: destination, isActive: $isActive) {
            CustomButtonView(title: buttonTitle) {
                print("Naviation")
                isActive = true
            }
        }
    }
}

struct CustomNavigationButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationButton(buttonTitle: "Some title") {

        }
    }
}
