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
        VStack {
            Circle()
                .frame(height: 200, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 70, bottom: 0, trailing: 70))

            if let title = title {
                Text(title)
            }
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(title: "Some title")
    }
}
