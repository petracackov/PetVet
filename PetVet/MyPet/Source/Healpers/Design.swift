//
//  Design.swift
//  MyPet
//
//  Created by Petra Cackov on 8. 7. 24.
//

import SwiftUI
import UIKit

// TODO: put all strings and texts in here
class Strings {
    
}

enum SystemIcon: String {
    case systemIconBell = "bell"
    case systemIconHouse = "house"
    case systemIconGear = "gearshape"
    case systemIconGearFill = "gearshape.fill"
    case systemIconPlus = "plus"
    case systemIconTrash = "trash"
    case systemIconTortoiseFill = "tortoise.fill"
    case systemIconChevronRight = "chevron.right"
    case systemIconChevronLeft = "chevron.left"
    case systemIconEdit = "square.and.pencil"
    case systemIconCamera = "camera"
    case systemIconSyringe = "syringe.fill"
    case systemIconBellFill = "bell.fill"
    case systemIconCalendar = "calendar"
    case systemIconStethoscope = "stethoscope"
    case systemIconPillsFill = "pills.fill"
    case systemIconClockFill = "clock.fill"
    
    var uiImage: UIImage {
        UIImage(systemName: self.rawValue)!.withRenderingMode(.alwaysTemplate)
    }
    
    var image: Image {
        Image(systemName: self.rawValue).renderingMode(.template)
    }
    
}

//extension Image {
//    
//    static var systemIconBell: Image { .init(systemName: "bell") }
//    static var systemIconHouse: Image { .init(systemName: "house") }
//    static var systemIconGear: Image { .init(systemName: "gearshape") }
//    static var systemIconPlus: Image { .init(systemName: "plus") }
//    static var systemIconTrash: Image { .init(systemName: "trash") }
//    static var systemIconTortoiseFill: Image { .init(systemName: "tortoise.fill") }
//    static var systemIconChevronRight: Image { .init(systemName: "chevron.right") }
//    static var systemIconChevronLeft: Image { .init(systemName: "chevron.left") }
//    static var systemIconEdit: Image { .init(systemName: "square.and.pencil") }
//    static var systemIconCamera: Image { .init(systemName: "camera") }
//    static var systemIconSyringe: Image { .init(systemName: "syringe.fill") }
//    static var systemIconBellFill: Image { .init(systemName: "bell.fill") }
//    static var systemIconCalendar: Image { .init(systemName: "calendar") }
//    static var systemIconStethoscope: Image { .init(systemName: "stethoscope") }
//    static var systemIconPillsFill: Image { .init(systemName: "pills.fill") }
//    static var systemIconClockFill: Image { .init(systemName: "clock.fill") }
//    
//}
//
//extension UIImage {
//    
//    static var systemIconBell: UIImage { .init(systemName: "bell")! }
//    static var systemIconHouse: UIImage { .init(systemName: "house")! }
//    static var systemIconGear: UIImage { .init(systemName: "gearshape")! }
//    static var systemIconPlus: UIImage { .init(systemName: "plus")! }
//    static var systemIconTrash: UIImage { .init(systemName: "trash")! }
//    static var systemIconTortoiseFill: UIImage { .init(systemName: "tortoise.fill")! }
//    static var systemIconChevronRight: UIImage { .init(systemName: "chevron.right")! }
//    static var systemIconChevronLeft: UIImage { .init(systemName: "chevron.left")! }
//    static var systemIconEdit: UIImage { .init(systemName: "square.and.pencil")! }
//    static var systemIconCamera: UIImage { .init(systemName: "camera")! }
//    static var systemIconSyringe: UIImage { .init(systemName: "syringe.fill")! }
//    static var systemIconBellFill: UIImage { .init(systemName: "bell.fill")! }
//    static var systemIconCalendar: UIImage { .init(systemName: "calendar")! }
//    static var systemIconStethoscope: UIImage { .init(systemName: "stethoscope")! }
//    static var systemIconPillsFill: UIImage { .init(systemName: "pills.fill")! }
//    static var systemIconClockFill: UIImage { .init(systemName: "clock.fill")! }
//
//    var image: Image {
//        Image(uiImage: self).renderingMode(.template)
//    }
//
//}
