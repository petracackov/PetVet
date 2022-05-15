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

    @State private var screenSize: CGSize = .zero

    var body: some View {

        VStack(alignment: .center, spacing: 20) {

            circleView()

            if let title = title {
                titleView(title)
            }
        }.getSize($screenSize)
    }

}

private extension ProfileHeaderView {


    func titleView(_ title: String) -> some View {
        Text(title)
            .font(.ui.titleBold)
            .foregroundColor(.ui.gray)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
    }

    func iconView(_ icon: String, width: CGFloat, leftAligned: Bool = false) -> some View {
        let offset = width/2 * 0.43
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

    func circleView() -> some View {
        HStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: screenSize.width * 0.6, height: screenSize.width * 0.6, alignment: .center)
                    .clipped()
                    .onTapGesture {
                        onSelection?()
                    }
                if let leftIcon = leftIcon {
                    iconView(leftIcon, width: screenSize.width, leftAligned: true)
                }

                if let rightIcon = rightIcon {
                    iconView(rightIcon, width: screenSize.width)
                }
            }
            Spacer()
        }
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
