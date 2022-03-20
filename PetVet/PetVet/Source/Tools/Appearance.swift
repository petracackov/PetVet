//
//  ColorTool.swift
//  PetrasWorkplaceSwiftUI
//
//  Created by Petra Cackov on 31/12/2021.
//

import Foundation
import UIKit
import SwiftUI

struct Appearance {

    struct Color {
        static var purple: UIColor = UIColor(named: "Purple")!
        static var orange: UIColor = UIColor(named: "Orange")!
        static var gray: UIColor = UIColor(named: "Gray")!
        static var white: UIColor = UIColor(named: "White")!
        static var background: UIColor = UIColor(named: "Background")!
        static var backgroundGray: UIColor = UIColor(named: "BackgroundGray")!
        static var borderGray: UIColor = UIColor(named: "BorderGray")!
    }

}

extension Color {

    static let ui = Color.UI()
    
    struct UI {
        let purple = Color(Appearance.Color.purple)
        let orange = Color(Appearance.Color.orange)
        let gray = Color(Appearance.Color.gray)
        let white = Color(Appearance.Color.white)
        let background = Color(Appearance.Color.background)
        let borderGray = Color(Appearance.Color.borderGray)
        let backgroundGray = Color(Appearance.Color.backgroundGray)
    }

}

extension Font {

    static let ui = Font.UI()

    struct UI {
        let title = Font.custom("Arial", size: 20)
        let titleBold = Font.custom("Arial-Bold", size: 20)
        let subtitle = Font.custom("Arial", size: 18)
        let description = Font.custom("Arial", size: 11)
    }
}
