//
//  Modifiers.swift
//  MyPet
//
//  Created by Petra Cackov on 1. 7. 24.
//

import SwiftUI

// MARK: - Button

extension View {
    
    @ViewBuilder func visibleWhen(_ condition: Bool) -> some View {
        if condition { self }
        else { self.hidden() }
    }
    
}

extension View {
    
    func asButton(action: @escaping () -> Void) -> some View {
        Button(action: action,
               label: { self })
    }
    
    func asButton<ItemType>(for item: ItemType, action: @escaping (ItemType) -> Void) -> some View {
        asButton { action(item) }
    }
    
}
