//
//  AppTextField.swift
//  MyPet
//
//  Created by Petra Cackov on 13. 7. 24.
//

import SwiftUI

struct AppTextField: View {
    
    @Binding var text: String
    let title: String
    @Namespace private var internalNamespace
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack {
                styledTitle()
                    .foregroundStyle(.clear)
                if !text.isEmpty {
                    styledTitle()
                        .foregroundStyle(.appGray3)
                        .matchedGeometryEffect(id: "label", in: internalNamespace)
                }
            }
           
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    styledTitle()
                        .foregroundStyle(.appGray1)
                        
                        
                        .matchedGeometryEffect(id: "label", in: internalNamespace)
                }
                TextField("", text: $text)
                    .frame(height: 30)
                    .accentColor(.appPurple)
            }
            .padding(.leading, 12)
            .clipShape(.capsule)
            .overlay {
                    Capsule()
                    .strokeBorder(.appGray3, lineWidth: 1)
                }
            
            
        }
        .frame(maxWidth: .infinity)
        .animation(.default, value: text)
        
    }
    
    private func styledTitle() -> some View {
        Text(title)
            .font(.body)
    }
}

#Preview {
    AppTextField(text: .constant("Test"), title: "Hello")
}
