//
//  NoDataView.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 7. 24.
//

import SwiftUI

enum NoDataType {
    case generic
    case events
    case medicalRecords
    case vets
    
    var images: [SystemIcon] {
        switch self {
        case .generic: [.systemIconPawprint]//[.systemIconTortoiseFill]
        case .events: [.systemIconBell]//[.systemIconBellFill, .systemIconCalendar, .systemIconClockFill]
        case .medicalRecords: [.systemIconSyringe, .systemIconStethoscope, .systemIconPillsFill]
        case .vets: [.systemIconStethoscope]
        }
    }
    
    var color: Color {
        switch self {
        case .generic: .appPurpleLightDarkReverse
        case .events: .appPurpleLightDarkReverse
        case .medicalRecords: .appOrangeLight
        case .vets: .appOrangeLight
        }
    }
}

struct NoDataView: View {
    
    let images: [SystemIcon]
    let title: String
    let color: Color
    let addDataAction: (() -> Void)?
    
    init(images: [SystemIcon] = [.systemIconTortoiseFill],
         title: String = "",
         color: Color = .appPurpleLightDark,
         addDataAction: (() -> Void)? = nil) {
        self.images = images
        self.title = title
        self.color = color
        self.addDataAction = addDataAction
    }
    
    init(_ type: NoDataType, title: String = "", addDataAction: (() -> Void)? = nil) {
        self.init(images: type.images, title: title, color: type.color, addDataAction: addDataAction)
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
            .padding(.horizontal, 80)
            if !title.isEmpty {
                Text(title)
                    .font(.largeTitle)
                    .foregroundStyle(color)
                    .multilineTextAlignment(.center)
            }
            
//            if let addDataAction {
//                SystemIcon.systemIconPlusCircle.image
//                    .resizable()
//                    .frame(width: 40, height: 40)
//                    .scaledToFit()
//                    .foregroundStyle(color)
//                    .asButton {
//                        addDataAction()
//                    }
//            }
        }
    }
}

#Preview {
    NoDataView(.generic, title: "Something") {
        print("something")
    }
}

#Preview {
    NoDataView()
}
