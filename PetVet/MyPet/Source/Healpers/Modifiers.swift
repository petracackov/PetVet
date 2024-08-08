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

extension View {
    
    @ViewBuilder
    func globalElementId(_ id: String, namespace: Namespace.ID?) -> some View {
        if let namespace {
            self.matchedGeometryEffect(id: id, in: namespace)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func globalElementId(_ id: String, item: String, namespace: Namespace.ID?) -> some View {
        if let namespace {
            self.matchedGeometryEffect(id: id + item, in: namespace)
        } else {
            self
        }
    }
    
}

extension View {
    
    func plainList() -> some View {
        self
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
    
}

extension View {
    
    
    func appGradient() -> some View {
        
        self.background(LinearGradient(colors: [.appPurpleGradient, .appBackground], startPoint: .bottom, endPoint: .top))
        
    }
    
}

fileprivate struct ToolbarItemModifier: ViewModifier {
    
    let icon: SystemIcon
    var placement: ToolbarItemPlacement
    let isVisible: Bool
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                if isVisible {
                    ToolbarItem(placement: placement) {
                        icon.image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                            .asButton {
                                action()
                            }
                    }
                }
            }
    }
    
}

extension View {
    
    func toolbarItem(_ icon: SystemIcon, placement: ToolbarItemPlacement = .topBarTrailing, isVisible: Bool = true, action: @escaping () -> Void) -> some View {
        modifier(ToolbarItemModifier(icon: icon, placement: placement, isVisible: isVisible, action: action))
    }
    
}

fileprivate struct NavigationTitleModifier: ViewModifier {
    
    let title: String
    let isVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                if isVisible {
                    ToolbarItem(placement: .principal) {
                        VStack(spacing: 0) {
                            Image(.logoSmall)
                                .resizable()
                                .scaledToFit()
                            Text(title)
                                .font(.body.bold())
                        }
                    }
                }
            }
    }
    
}

extension View {
    
    func navigationBarTitle(_ title: String, isVisible: Bool = true) -> some View {
        modifier(NavigationTitleModifier(title: title, isVisible: isVisible))
    }
    
}

