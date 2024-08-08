//
//  LaunchScreenUI.swift
//  MyPet
//
//  Created by Petra Cackov on 7. 8. 24.
//

import SwiftUI

struct LaunchScreenUI: View {
    
    @State var scale: CGFloat  = 1
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(.launchLogo)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(CGSize(width: scale, height: scale))
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .appGradient()
        .onAppear {
            withAnimation(.easeIn(duration: 0.3).delay(0.2)) {
                scale = 1.1
            }
            
            withAnimation(.easeOut(duration: 0.3).delay(0.5)) {
                scale = 1.0
            }
        }
    }
}

#Preview {
    LaunchScreenUI()
}
