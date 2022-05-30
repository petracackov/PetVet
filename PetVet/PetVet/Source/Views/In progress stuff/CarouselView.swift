//
//  CarouselView.swift
//  PetVet
//
//  Created by Petra Cackov on 28/05/2022.
//

import SwiftUI

struct CarouselView<Content: View, T: Identifiable>: View {

    var items: [T]
    var spacing: CGFloat = 0
    var topInset: CGFloat = 0
    var bottomInset: CGFloat = 0
    var leadingInset: CGFloat = 0
    var trailingInset: CGFloat = 0
    var content: (T) -> Content

    
    @State var index: Int = 0
    @State var cellSize: CGSize = .zero
    @GestureState var offset: CGFloat = 0

    var contentSize: CGSize {
        let width = CGFloat(items.count) * (cellSize.width + spacing) + leadingInset + trailingInset
        let height = cellSize.height + topInset + bottomInset
        return CGSize(width: width, height: height)
    }

    var body: some View {

        LazyHStack(spacing: spacing) {
            ForEach(items) { item in
                GeometryReader { proxy in
                    ZStack(alignment: .bottom) {
                        content(item)
                        Text(proxy.frame(in: .global).minX.description)
                            .frame(height: 40)
                    }
                    .getSize($cellSize)


                }
                .frame(width: cellSize.width, height: cellSize.height)
            }
        }
        .padding(EdgeInsets(top: topInset, leading: leadingInset, bottom: bottomInset, trailing: trailingInset))
        .gesture(
            DragGesture()
                .updating($offset, body: { value, state, transaction in
                   print(value, state, transaction)
                })
                .onEnded({ value in
                    print("")
                })
        )
    }

}

struct CarouselView_Previews: PreviewProvider {
    struct Item: Identifiable {
        var id: Int
    }
    private static let items: [Item] = Array(0...100).map { Item(id: $0)}
    static var previews: some View {
        GeometryReader { proxy in
            CarouselView(items: items, spacing: 5) { item in
                Text(item.id.description)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .background(.red)
            }
        }.ignoresSafeArea()

    }
}
