//
//  ProfileHeaderView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct ProfileHeaderView: View {

    var title: String?

    var body: some View {
        GeometryReader { geometryReader in

            VStack(alignment: .center, spacing: 20) {
                Spacer()
                Circle()
                    .frame(height: geometryReader.size.width * 0.6, alignment: .center)

                if let title = title {
                    Text(title)
                        .font(.ui.titleBold)
                        .foregroundColor(.ui.gray)
                }
                Spacer()
            }
        }

    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileHeaderView(title: "Some title")
                .edgesIgnoringSafeArea(.all)
        }
    }
}
