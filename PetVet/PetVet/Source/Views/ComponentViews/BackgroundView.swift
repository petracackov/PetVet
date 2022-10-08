//
//  BackgroundView.swift
//  PetrasWorkplaceSwiftUI
//
//  Created by Petra Cackov on 18/01/2022.
//

import SwiftUI

struct BackgroundView: View {

    private let style: Style

    init(color: Color) {
        self.style = .oneColor(color)
    }

    init(gradientColors: [Color]) {
        self.style = .gradient(colors: gradientColors)
    }

    var body: some View {
        switch style {
        case .gradient(let colors):
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea()
        case .oneColor(let color):
            color.edgesIgnoringSafeArea(.all)
        }
    }

    enum Style {
        case gradient(colors: [Color])
        case oneColor(Color)
    }

}

struct ColoredBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(color: .blue)
    }
}
