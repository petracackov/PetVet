//
//  NoDataView.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

enum NoDataType {
    case generic
    case eventsBig
    case eventsSmall
    case medicalRecords
    case vets
    
    var images: [SystemIcon] {
        switch self {
        case .generic: [.systemIconPawprint]
        case .eventsBig: [.systemIconBell]
        case .eventsSmall: [.systemIconBellFill, .systemIconCalendar, .systemIconClockFill]
        case .medicalRecords: [.systemIconSyringe, .systemIconStethoscope, .systemIconPillsFill]
        case .vets: [.systemIconStethoscope]
        }
    }
    
    var color: Color {
        switch self {
        case .generic: .appPurpleLightDarkReverse
        case .eventsBig, .eventsSmall: .appPurpleLightDarkReverse
        case .medicalRecords: .appOrangeLight
        case .vets: .appOrangeLight
        }
    }
    
    var padding: CGFloat {
        switch self {
        case .generic: 80
        case .eventsBig: 80
        case .eventsSmall: 0
        case .medicalRecords: 0
        case .vets: 0
        }
    }
}

struct NoDataView: View {
    
    let images: [SystemIcon]
    let title: String
    let color: Color
    let padding: CGFloat
    let addDataAction: (() -> Void)?
    
    init(images: [SystemIcon] = [.systemIconTortoiseFill],
         title: String = "",
         color: Color = .appPurpleLightDark,
         padding: CGFloat = 0.0,
         addDataAction: (() -> Void)? = nil) {
        self.images = images
        self.title = title
        self.color = color
        self.padding = padding
        self.addDataAction = addDataAction
    }
    
    init(_ type: NoDataType, title: String = "", addDataAction: (() -> Void)? = nil) {
        self.init(images: type.images, title: title, color: type.color, padding: type.padding, addDataAction: addDataAction)
    }
    
    var body: some View {
        if let addDataAction {
            contentView()
                .asButton {
                    addDataAction()
                }
        } else {
            contentView()
        }
    }
    
    private func contentView() -> some View {
        VStack {
            HStack {
                ForEach(images, id: \.self) { uiImage in
                    uiImage.image
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(color)
                        .padding()
                }
            }
            .padding(.horizontal, padding)
            
            if !title.isEmpty {
                Text(title)
                    .font(.largeTitle)
                    .foregroundStyle(color)
                    .multilineTextAlignment(.center)
            }
            
        }
    }
}

#Preview {
    NoDataView(.generic, title: "Something") {
        print("something")
    }
}

#Preview {
    NoDataView(.eventsSmall)
}

#Preview {
    NoDataView(.eventsBig)
}

#Preview {
    NoDataView()
}
