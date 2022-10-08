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

    func descriptionStyle() -> some View {
        modifier(DescriptionText())
    }
}

fileprivate struct TitleText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.ui.title)
            .foregroundColor(.petVet(.gray3))
    }
}

fileprivate struct DescriptionText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.ui.description)
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
                    readSize(proxy.frame(in: .local).size)
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


// MARK: - Rounded

extension View {
    func rounded(borderColor: Color = .clear) -> some View {
        modifier(RoundedView(borderColor: borderColor))
    }
}

fileprivate struct RoundedView: ViewModifier {
    var borderColor: Color
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(borderColor, style: StrokeStyle(lineWidth: 2))

            )
    }
}

