//
//  BackgroundView.swift
//  PetrasWorkplaceSwiftUI
//
//  Created by Petra Cackov on 18/01/2022.
//

import SwiftUI

struct BackgroundView: View {

    let color: Color

    var body: some View {
        color.edgesIgnoringSafeArea(.all)
    }

}

struct ColoredBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(color: .black)
    }
}
