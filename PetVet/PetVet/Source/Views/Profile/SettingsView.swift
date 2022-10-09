//
//  SettingsView.swift
//  PetVet
//
//  Created by Petra Cackov on 09/10/2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        CustomButtonView(title: "Log out", backgroundColor: .ui.purple) {
            User.logOut()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
