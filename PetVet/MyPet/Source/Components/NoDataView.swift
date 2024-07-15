//
//  NoDataView.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

struct NoDataView: View {
    
    var image: Image = Image.systemIconTortoiseFill
    var title: String = ""
    var color: Color = .appPurpleLightDark
    
    var body: some View {
        VStack {
           image
                .resizable()
                .scaledToFit()
                .foregroundStyle(color)
                .padding()
            Text(title)
                .font(.largeTitle)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    NoDataView()
}
