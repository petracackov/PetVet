//
//  EventCell.swift
//  MyPet
//
//  Created by Petra Cackov on 14. 7. 24.
//

import SwiftUI
import SwiftData

struct EventCell: View {
    
    let event: PetEvent
    let showPet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(showPet ? event.pet.name : "")
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
            
        }
        .padding(.horizontal, 15)
        .background(.appGray3.opacity(0.2))
        .clipShape(.rect(cornerRadius: 15))
        .padding(.vertical, 5)
    }
    
    
}

#Preview {
    let _ = DataSource.shared
    let firstEvent = MockedData.events[0]
    let secondEvent = MockedData.events[2]
    
    return VStack(spacing: 0) {
        EventCell(event: firstEvent, showPet: true)
        EventCell(event: secondEvent, showPet: false)
    }

}

