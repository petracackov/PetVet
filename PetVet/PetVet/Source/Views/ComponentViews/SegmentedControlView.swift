//
//  SegmentedControlView.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI

struct SegmentedControlView: View {

    let items: [String]
    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                SmallButton(title: item, isSelected: index == selectedIndex) {
                    withAnimation {
                        self.selectedIndex = index
                    }
                }
            }
        }
    }

}

private struct SmallButton: View {

    var title: String
    var isSelected: Bool
    var onAction: (() -> Void)

    private var backgroundColor: Color { isSelected ? .ui.purple : .clear }
    private var textColor: Color { isSelected ? .ui.white : .ui.gray }
    private var borderColor: Color { isSelected ? .clear : .ui.borderGray}

    var body: some View {
        Button {
            onAction()
        } label: {
            Text(title)
                .foregroundColor(textColor)
                .font(.ui.title)
        }
        .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
        .background(backgroundColor)
        .clipShape(Capsule())
        .overlay(
            Capsule(style: .continuous)
                .stroke(borderColor, style: StrokeStyle(lineWidth: 2))
        )
    }
}



struct SegmentedControlView_Previews: PreviewProvider {
    @State static var selectedIndex: Int = 0
    static var previews: some View {
        SegmentedControlView(items: ["hello", "2", "loooong"], selectedIndex: $selectedIndex)
    }
}
