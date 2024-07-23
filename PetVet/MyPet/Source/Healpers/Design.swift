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

extension Image {
    
    static var systemIconBell: Image { UIImage.systemIconBell.image }
    static var systemIconHouse: Image {  UIImage.systemIconHouse.image }
    static var systemIconGear: Image {  UIImage.systemIconGear.image}
    static var systemIconPlus: Image {  UIImage.systemIconPlus.image }
    static var systemIconTrash: Image { UIImage.systemIconTrash.image }
    static var systemIconTortoiseFill: Image {  UIImage.systemIconTortoiseFill.image }
    static var systemIconChevronRight: Image {  UIImage.systemIconChevronRight.image }
    static var systemIconChevronLeft: Image {  UIImage.systemIconChevronLeft.image }
    static var systemIconEdit: Image {  UIImage.systemIconEdit.image }
    static var systemIconCamera: Image {  UIImage.systemIconCamera.image }
    static var systemIconSyringe: Image { UIImage.systemIconSyringe.image }
    static var systemIconBellFill: Image { UIImage.systemIconBellFill.image}
    static var systemIconCalendar: Image { UIImage.systemIconCalendar.image }
    static var systemIconStethoscope: Image { UIImage.systemIconStethoscope.image }
    static var systemIconPillsFill: Image { UIImage.systemIconPillsFill.image }
    static var systemIconClockFill: Image { UIImage.systemIconClockFill.image }
    
}

extension UIImage {
    
    static var systemIconBell: UIImage { .init(systemName: "bell")! }
    static var systemIconHouse: UIImage { .init(systemName: "house")! }
    static var systemIconGear: UIImage { .init(systemName: "gearshape")! }
    static var systemIconPlus: UIImage { .init(systemName: "plus")! }
    static var systemIconTrash: UIImage { .init(systemName: "trash")! }
    static var systemIconTortoiseFill: UIImage { .init(systemName: "tortoise.fill")! }
    static var systemIconChevronRight: UIImage { .init(systemName: "chevron.right")! }
    static var systemIconChevronLeft: UIImage { .init(systemName: "chevron.left")! }
    static var systemIconEdit: UIImage { .init(systemName: "square.and.pencil")! }
    static var systemIconCamera: UIImage { .init(systemName: "camera")! }
    static var systemIconSyringe: UIImage { .init(systemName: "syringe.fill")! }
    static var systemIconBellFill: UIImage { .init(systemName: "bell.fill")! }
    static var systemIconCalendar: UIImage { .init(systemName: "calendar")! }
    static var systemIconStethoscope: UIImage { .init(systemName: "stethoscope")! }
    static var systemIconPillsFill: UIImage { .init(systemName: "pills.fill")! }
    static var systemIconClockFill: UIImage { .init(systemName: "clock.fill")! }
    
    var image: Image {
        Image(uiImage: self).renderingMode(.template)
    }
    
}
