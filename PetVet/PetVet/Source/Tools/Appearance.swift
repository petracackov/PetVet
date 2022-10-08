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

    enum Color1 {
        case purple 
        case purpleLight
        case orange
        case orangeLight
        case white
        case black
        case gray1
        case gray2

        case gray3
        case blackWhite
        case whiteBlack

        var value: UIColor {
            switch self {
            case .purple: return R.color.purple()!
            case .purpleLight: return R.color.purpleLight()!
            case .orange: return R.color.orange()!
            case .orangeLight: return R.color.orangeLight()!
            case .white: return R.color.white()!
            case .black: return R.color.black()!
            case .gray1: return R.color.gray1()!
            case .gray2: return R.color.gray2()!
            case .gray3: return R.color.gray3()!
            case .blackWhite: return R.color.blackWhite()!
            case .whiteBlack: return R.color.whiteBlack()!
            }
        }
    }

    struct Color {
        // MARK: - Base
        static var purple: UIColor = R.color.purple()!
        static var purpleLight: UIColor = R.color.purpleLight()!
        static var orange: UIColor = R.color.orange()!
        static var orangeLight: UIColor = R.color.orangeLight()!
        static var white: UIColor = R.color.white()!
        static var black: UIColor = R.color.black()!
        static var gray1: UIColor = R.color.gray1()!
        static var gray2: UIColor = R.color.gray2()!

        // MARK: - Dark mode
        static var gray3: UIColor = R.color.gray3()!
        static var blackWhite: UIColor = R.color.blackWhite()!
        static var whiteBlack: UIColor = R.color.whiteBlack()!

        // Deprecated
        static var background: UIColor = UIColor(named: "Background")!
        static var backgroundGray: UIColor = UIColor(named: "BackgroundGray")!
        static var borderGray: UIColor = UIColor(named: "BorderGray")!
        static var text: UIColor = UIColor(named: "Text")!
        static var gray = UIColor(named: "Text")!
    }

}
let color: Color = .petVet(.purple)

extension UIColor {
    static func petVet(_ color: Appearance.Color1) -> UIColor {
        return color.value
    }
}

extension Color {

    static func petVet(_ color: Appearance.Color1) -> Color {
        return Color(.black)
    }
    static let ui = Color.UI()
    
    struct UI {
        let purple = Color(Appearance.Color.purple)
        let orange = Color(Appearance.Color.orange)
        let gray = Color(Appearance.Color.gray)
        let white = Color(Appearance.Color.white)
        let black = Color(Appearance.Color.black)
        let background = Color(Appearance.Color.background)
        let borderGray = Color(Appearance.Color.borderGray)
        let backgroundGray = Color(Appearance.Color.backgroundGray)
        let text = Color(Appearance.Color.text)
    }

}

extension Font {

    static let ui = Font.UI()

    struct UI {
        let title = Font.custom("Arial", size: 20)
        let titleBold = Font.custom("Arial-Bold", size: 20)
        let subtitle = Font.custom("Arial", size: 18)
        let description = Font.custom("Arial", size: 11)

        func arialFont(withSize size: CGFloat) -> Font {
            return Font.custom("Arial", size: size)
        }
    }
}
