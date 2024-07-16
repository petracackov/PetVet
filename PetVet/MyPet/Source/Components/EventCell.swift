//
//  EventCell.swift
//  MyPet
//
//  Created by Petra Cackov on 14. 7. 24.
//

import SwiftUI

struct EventCell: View {
    
    let event: PetEvent
    var pet: Pet?
    let isLast: Bool
    let isFirst: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(pet?.name ?? "")
                    .font(.caption2)
                    .foregroundStyle(.appBlackWhite)
                    .padding(.top, 10)
                    .padding(.horizontal, 10)
                Spacer()
                Circle()
                    .foregroundStyle(event.completed ? .appPurple : .appOrange)
                    .frame(width: 10, height: 10)
                    .padding(.top, 10)
            }
            
            HStack {
                Text(event.title)
                    .font(.title2)
                    .foregroundStyle(.appBlackWhite)
                Spacer()
                Text(event.date.string)
                    .font(.body)
                    .foregroundStyle(.appBlackWhite)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            
            Text(event.eventDescription)
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
    let modelContext = DataSource.shared.modelContext
    return VStack(spacing: 0) {
        EventCell(event: MockedData.events.first!, pet: MockedData.pets[1], isLast: false, isFirst: true)
        EventCell(event: MockedData.events[2], pet: MockedData.pets.first!, isLast: true, isFirst: false)
    }
    .modelContext(modelContext)

}

#Preview {
    let modelContext = DataSource.shared.modelContext
    return VStack(spacing: 0) {
        EventCell(event: MockedData.events[1], pet: nil, isLast: false, isFirst: true)
        EventCell(event: MockedData.events.first!, pet: nil, isLast: true, isFirst: false)
    }
    .modelContext(modelContext)

}

