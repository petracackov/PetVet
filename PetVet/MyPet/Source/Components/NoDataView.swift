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
    
    var images: [SystemIcon] {
        switch self {
        case .generic: [.systemIconTortoiseFill]
        case .events: [.systemIconBellFill, .systemIconCalendar, .systemIconClockFill]
        case .medicalRecords: [.systemIconSyringe, .systemIconStethoscope, .systemIconPillsFill]
        }
    }
    
    var color: Color {
        switch self {
        case .generic: .appPurpleLightDark
        case .events: .appPurpleLightDark
        case .medicalRecords: .appOrangeLight
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
            if !title.isEmpty {
                Text(title)
                    .font(.largeTitle)
                    .foregroundStyle(color)
                    .multilineTextAlignment(.center)
            }
            
            if let addDataAction {
                SystemIcon.systemIconPlus.image
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .foregroundStyle(color)
                    .asButton {
                        addDataAction()
                    }
            }
        }
    }
}

#Preview {
    NoDataView()
}
