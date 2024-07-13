//
//  NoDataView.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        VStack {
            Image.systemIconTortoiseFill
                .resizable()
                .scaledToFit()
                .foregroundStyle(.appPurpleLight)
                .padding()
            Text("No data")
                .font(.largeTitle)
                .foregroundStyle(.appPurple)
        }
    }
}

#Preview {
    NoDataView()
}
