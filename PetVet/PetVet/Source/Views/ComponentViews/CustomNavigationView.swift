//
//  CustomNavigationView.swift.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import SwiftUI

struct CustomNavigationView<ContentView: View>: View {

    //var navigationBarIsHidden: Bool = false
    //var title: String = ""
    @ViewBuilder var contentView: ContentView

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
//                if !navigationBarIsHidden {
////                    ZStack {
////                        Rectangle()
////                            .background(.clear)
////                            .foregroundColor(.clear)
////                        Text(title)
////                            .font(.ui.titleBold)
////                            .foregroundColor(.ui.gray)
////                    }
////                    .frame(height: 44)
//                    Rectangle()
//                        .frame(height: 10)
//                        .foregroundColor(.red)
//                }
//                Spacer()
                contentView
//                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NavigationBarSeparator_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView() {
            Text("Hello")
        }.navigationTitle("SometItle")
    }
}
