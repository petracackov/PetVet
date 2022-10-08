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
        case purpleGradient

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
            case .purpleGradient: return R.color.purpleGradient()!
            }
        }
    }


    struct Color2 {
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
        static var borderGray: UIColor = UIColor(named: "Gray1")!
        static var text: UIColor = UIColor(named: "Text")!
        static var gray = UIColor(named: "Text")!
    }

    enum Gradient {
        case purple
        case orange
        case purpleTransparent

        var colorTypes: [Appearance.Color1] {
            switch self {
            case .purple: return [.purpleLight, .purple]
            case .orange: return [.orangeLight, .orange]
            case .purpleTransparent: return [.whiteBlack, .purpleGradient]
            }
        }

        var uiColors: [UIColor] {
            return self.colorTypes.map { $0.value }
        }

        var colors: [Color] {
            return self.colorTypes.map { Color($0.value) }
        }
    }

}

extension UIColor {
    static func petVet(_ color: Appearance.Color1) -> UIColor {
        return color.value
    }
}

extension Color {

    static func petVet(_ color: Appearance.Color1) -> Color {
        return Color(color.value)
    }
    static let ui = Color.UI()
    
    struct UI {
        let purple = Color(Appearance.Color2.purple)
        let orange = Color(Appearance.Color2.orange)
        let gray = Color(Appearance.Color2.gray)
        let white = Color(Appearance.Color2.white)
        let black = Color(Appearance.Color2.black)
        let background = Color(Appearance.Color2.background)
        let borderGray = Color(Appearance.Color2.borderGray)
        let backgroundGray = Color(Appearance.Color2.backgroundGray)
        let text = Color(Appearance.Color2.text)
    }

}

extension Font {

    static let ui = Font.UI()

    struct UI {
        let title = Font.custom("Arial", size: 20)
        let titleBold = Font.custom("Arial-BoldMT", size: 20)
        let subtitle = Font.custom("Arial", size: 18)
        let description = Font.custom("Arial", size: 11)

        func arialFont(withSize size: CGFloat) -> Font {
            return Font.custom("Arial", size: size)
        }
    }
}


