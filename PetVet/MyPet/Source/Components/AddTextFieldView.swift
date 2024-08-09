//
//  AddTextFieldView.swift
//  MyPet
//
//  Created by Petra Cackov on 9. 8. 24.
//

import SwiftUI

struct AddTextFieldView: View {
    
    let title: String
    var maxFields = 1
    @Binding var values: [String]
    
    var body: some View {
        VStack {
            ForEach(Array(values.enumerated()), id: \.self.offset) { index, value in
                HStack {
                    VStack(spacing: 0) {
                        emptyTextPlaceholder()
                        CircleEditIcon(type: .remove)
                            .asButton {
                                values.remove(at: index)
                            }
                            .padding(.vertical, 3)
                    }
                    
                    AppTextField(text: $values[index], title: title)
                }
            }
            if values.count < maxFields {
                VStack(spacing: 0) {
                    if values.count == 0 {
                        emptyTextPlaceholder()
                    }
                    addButtonView(title: "Add \(title)")
                        .padding(.vertical, 3)
                        .padding(.leading, values.count > 0 ? 30 : 0)
                        .asButton {
                            values.append("")
                        }
                        
                }
            }
        }
    }
    
    
    private func addButtonView(title: String) -> some View {
            HStack {
                CircleEditIcon(type: .add)
                Text(title)
                    .foregroundStyle(.appText)
                Spacer()
            }
            
    }
    
    private func emptyTextPlaceholder() -> some View {
        Text(" ")
            .foregroundStyle(.clear)
            .font(.body)
            .padding(.bottom, 5)// to match the spacing of text field
    }
}

#Preview {
    VStack {
        AddTextFieldView(title: "Email", maxFields: 4, values: .constant(["petra.cackov@gmail.com"]))
        AddTextFieldView(title: "Email", maxFields: 4, values: .constant([]))
    }
}
