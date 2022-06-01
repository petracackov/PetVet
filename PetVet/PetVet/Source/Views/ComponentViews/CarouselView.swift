//
//  CarouselView.swift
//  PetVet
//
//  Created by Petra Cackov on 28/05/2022.
//

import SwiftUI

struct CarouselView<Content: View, T: Identifiable>: View {

    @Binding var currentIndex: Int
    @State private var cellSize: CGSize = .zero
    @State private var scrollOffset: CGFloat = 0.0
    @State private var dragOffset: CGFloat = 0.0

    var items: [T]
    var spacing: CGFloat = 0
    var topInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var leadingInset: CGFloat = 0
    var trailingInset: CGFloat = 0
    var content: (T) -> Content

    var body: some View {

        LazyHStack(spacing: spacing) {
            ForEach(items) { item in
                content(item)
                    .getSize($cellSize)

            }
        }
        .padding(EdgeInsets(top: topInset, leading: leadingInset, bottom: bottomInset, trailing: trailingInset))
        .offset(x: scrollOffset + dragOffset)
        .gesture(
            DragGesture()
                .onChanged({ event in
                    dragOffset = event.translation.width
                })
                .onEnded({ event in

                    scrollOffset += event.translation.width
                    dragOffset = 0


                    let itemWidth = cellSize.width + spacing
                    var index = max((-scrollOffset)/itemWidth, 0)
                    let indexReminder = index - index.rounded(.down)

                    if indexReminder < 0.5 {
                        index = CGFloat(Int(index))
                    } else {
                        index = CGFloat(Int(index)) + 1
                    }

                    index = max(min(index, CGFloat(items.count) - 1), 0)

                    currentIndex = Int(index)
                    // Animate snapping
                    withAnimation {
                        scrollOffset = -index*(cellSize.width + spacing)
                    }

                })
        )

    }

}

struct CarouselView_Previews: PreviewProvider {

    @State private static var index = 0
    private static let items: [Item] = Array(0...100).map { Item(id: $0)}

    struct Item: Identifiable { var id: Int }

    static var previews: some View {
        GeometryReader { proxy in
            CarouselView(currentIndex: $index, items: items, spacing: 0) { item in
                Text(item.id.description)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .background(.red)
            }
        }.ignoresSafeArea()

    }
}
