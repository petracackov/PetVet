//
//  ManageVetView.swift
//  MyPet
//
//  Created by Petra Cackov on 8. 8. 24.
//

import SwiftUI

struct ManageVetView: View {
    var body: some View {
        
        ScrollView {
            VStack {
                
                AppButton(title: "Save") {
                    print("Save")
                }
            }
        }
        
    }
}

#Preview {
    ManageVetView()
}
