//
//  ProfileView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct ProfileView: View {

    var body: some View {
        ZStack {
            BackgroundView(color: .ui.background)
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ProfileHeaderView()
                    dataView(title: "Adress", content: "Some Adress")
                    dataView(title: "Adress", content: "Some Adress")
                    dataView(title: "Adress", content: "Some Adress")
                    Spacer()
                    CustomButtonView(title: "Log out", backgroundColor: .ui.purple) {
                        User.logOut()
                    }
                }

            }.padding()
        }
    }

    func dataView(title: String, content: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
            Text(content)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            ProfileView()
        }
    }
}
