//
//  MedicalRecordCell.swift
//  MyPet
//
//  Created by Petra Cackov on 14. 7. 24.
//

import SwiftUI

struct MedicalRecordCell: View {
    
    let title: String
    let date: String
    let description: String
    let isFirst: Bool
    let isLast: Bool
    
    var body: some View {
    
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title2)
                    .foregroundStyle(.appBlackWhite)
                Spacer()
                Text(date)
                    .font(.body)
                    .foregroundStyle(.appBlackWhite)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .padding(.top, 20)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.appBlackWhite)
            
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
            
            
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(isLast ? .clear : .appBlackWhite)
            
            
        }
        .padding(.horizontal, 15)
        .background(.appGray3.opacity(0.2))
        .clipShape(.rect(topLeadingRadius: isFirst ? 15 : 0,
                         bottomLeadingRadius: isLast ? 15 : 0,
                         bottomTrailingRadius:  isLast ? 15 : 0,
                         topTrailingRadius: isFirst ? 15 : 0))
    }
    
}

#Preview {
    VStack(spacing: 0) {
        MedicalRecordCell(title: "Vaccine", date: Date().string, description: "Some description", isFirst: true, isLast: false)
        MedicalRecordCell(title: "Vaccine", date: Date().string, description: "Some description", isFirst: false, isLast: true)
    }

}
