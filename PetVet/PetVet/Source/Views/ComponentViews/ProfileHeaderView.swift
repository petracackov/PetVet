//
//  ProfileHeaderView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct ProfileHeaderView: View {

    var title: String?
    var leftIcon: String?
    var rightIcon: String?
    var onSelection: (() -> Void)?
    @State var circleHeight: CGFloat = .zero
    @State var textHeight: CGFloat = .zero

    var body: some View {
        GeometryReader { geometryReader in

            VStack(alignment: .center, spacing: 20) {
                ZStack {
                    Circle()
                        .frame(width: geometryReader.size.width * 0.6, height: geometryReader.size.width * 0.6, alignment: .center)
                        .clipped()
                        .onTapGesture {
                            onSelection?()
                        }
                        .onAppear {
                            circleHeight = geometryReader.size.width * 0.6
                        }
                    if let leftIcon = leftIcon {
                        iconView(leftIcon, geometryReader: geometryReader, leftAligned: true)
                    }

                    if let rightIcon = rightIcon {
                        iconView(rightIcon, geometryReader: geometryReader)
                    }
                }


                if let title = title {
                    titleView(title)
                }
            }
            .position(x: geometryReader.size.width/2, y: geometryReader.size.height/2)
        }
        .frame(maxWidth: .infinity, minHeight: circleHeight + textHeight + 20, maxHeight: .infinity) // needed if the view is placed in scroll view
    }
}

private extension ProfileHeaderView {


    func titleView(_ title: String) -> some View {
        Text(title)
            .font(.ui.titleBold)
            .foregroundColor(.ui.gray)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .background(
                GeometryReader { textGeometryReader in
                    Color.clear
                        .onAppear {
                            textHeight = textGeometryReader.size.height
                        }
                }
            )
    }

    func iconView(_ icon: String, geometryReader: GeometryProxy, leftAligned: Bool = false) -> some View {
        let offset = geometryReader.size.width/2 * 0.43
        return ZStack(alignment: .center) {
            Circle()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(Color.ui.backgroundGray)
            Text(icon)
                .font(.ui.title)
                .foregroundColor(.ui.gray)
        }
        .offset(CGSize(width: leftAligned ? -offset : offset, height: offset))
    }

}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileHeaderView(title: "Some title", leftIcon: "🦁", rightIcon: "♂")
                .edgesIgnoringSafeArea(.all)
        }
    }
}
