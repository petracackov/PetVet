//
//  ProfileView.swift
//  PetVet
//
//  Created by Petra Cackov on 12/02/2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            ProfileHeaderView()
            Spacer(minLength: 20)
            VStack(spacing: 20) {
                dataView(title: "Adress", content: "Some Adress")
                dataView(title: "Adress", content: "Some Adress")
                dataView(title: "Adress", content: "Some Adress")
            }
            .frame(minWidth: UIScreen.main.bounds.width - 40, alignment: .leading)
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
