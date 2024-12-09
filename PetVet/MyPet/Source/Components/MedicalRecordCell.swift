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
            .padding(.top, 10)
            Text(description)
                .font(.subheadline)
                .foregroundStyle(.appBlackWhite)
            
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
        }
        .padding(.horizontal, 15)
        .background(.appGray3.opacity(0.2))
        .clipShape(.rect(cornerRadius: 15))
        .padding(.vertical, 5)
    }
    
}

#Preview {
    VStack(spacing: 0) {
        MedicalRecordCell(title: "Vaccine", date: Date().string, description: "Some description")
        MedicalRecordCell(title: "Vaccine", date: Date().string, description: "Some description")
    }

}
