//
//  Modifiers.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI


// MARK: - TextTitle

extension View {
    func titleStyle() -> some View {
        modifier(TitleText())
    }
}

fileprivate struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.ui.title)
            .foregroundColor(.ui.gray)
    }
}

// MARK: - SizeReader

extension View {

    func getSize(_ size: Binding<CGSize>) -> some View {
        modifier(SizeReader(size: size))
    }


}

fileprivate struct SizeReader: ViewModifier {

    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    readSize(proxy.size)
                }
            )
    }

    private func readSize(_ size: CGSize) -> some View {
        DispatchQueue.main.async {
            self.size = size
        }
        return Color.clear
    }
}


