//
//  View+navigation.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI

extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationLink(
            destination: view
                .navigationBarTitle("")
                .navigationBarHidden(true),
            isActive: binding
        ) {
           EmptyView()
        }
    }

    /// Dismisses keyboard when tapped on view
    func hideKeyboard() -> some View  {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                  to: nil, from: nil, for: nil)
        }
    }

}
