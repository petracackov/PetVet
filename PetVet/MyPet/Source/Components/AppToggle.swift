//
//  AppToggle.swift
//  MyPet
//
//  Created by Petra Cackov on 16. 7. 24.
//

import SwiftUI

struct AppToggle: View {
    
    @Binding var isOn: Bool
    let title: String
    var description: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle(isOn: $isOn, label: {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.appGray3)
            })
            .toggleStyle(.switch)
            .tint(.appPurple)
            
            if let description {
                Text(description)
                    .font(.footnote)
                    .foregroundStyle(.appGray3.opacity(0.6))
            }
        }
    }
}

#Preview {
    AppToggle(isOn: .constant(true), title: "Title", description: "Description")
}
