//
//  EmojiView.swift
//  PetVet
//
//  Created by Petra Cackov on 24/04/2022.
//

import SwiftUI

struct EmojiView: View {
    
    var emoji: String
    var colors: [Color] = Appearance.Gradient.purple.colors
    var border: Color = .clear

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(border, lineWidth: 3)
                .background(
                    LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
                )
                .rounded()

            Text(emoji)
                .font(.system(size: 35))
        }.frame(width: 60, height: 60, alignment: .center)
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(emoji: "🐈")
    }
}
