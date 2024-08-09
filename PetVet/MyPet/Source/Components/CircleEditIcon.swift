//
//  CircleEditIcon.swift
//  MyPet
//
//  Created by Petra Cackov on 9. 8. 24.
//

import SwiftUI

struct CircleEditIcon: View {
    
    let type: EditButton
    
    var body: some View {
        ZStack {
            type.image
                .foregroundStyle(.white)
        }
        .frame(width: 24, height: 24)
        .background(type.color)
        .clipShape(Circle())
    }
    
    enum EditButton {
        case add, remove
        
        var image: Image {
            switch self {
            case .add: SystemIcon.systemIconPlus.image
            case .remove: SystemIcon.systemIconMinus.image
            }
        }
        
        var color: Color {
            switch self {
            case .add: .appPurpleLightDarkReverse
            case .remove: .appOrange
            }
        }
    }
}

#Preview {
    VStack {
        CircleEditIcon(type: .add)
        CircleEditIcon(type: .remove)
    }
}
