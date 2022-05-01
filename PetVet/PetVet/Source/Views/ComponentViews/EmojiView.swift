//
//  EmojiView.swift
//  PetVet
//
//  Created by Petra Cackov on 24/04/2022.
//

import SwiftUI

struct EmojiView: View {
    
    var emoji: String
    var background: Color = Color.ui.backgroundGray
    var border: Color = .clear

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(border, lineWidth: 3)
                .background(Circle().fill(background))
                .frame(width: 60, height: 60, alignment: .center)
            Text(emoji)
                .font(.system(size: 35))
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(emoji: "🐈")
    }
}
