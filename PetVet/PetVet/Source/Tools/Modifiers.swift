//
//  Modifiers.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        modifier(TitleText())
    }
}

struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.ui.title)
            .foregroundColor(.ui.gray)
    }
}
