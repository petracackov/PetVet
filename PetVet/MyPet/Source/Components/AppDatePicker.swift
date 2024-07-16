//
//  AppDatePicker.swift
//  MyPet
//
//  Created by Petra Cackov on 16. 7. 24.
//

import SwiftUI

struct AppDatePicker: View {
    
    @Binding var date: Date
    var title: String = ""
    let components: DatePickerComponents
    
    var body: some View {
        DatePicker(selection: $date, displayedComponents: components) {
            Text(title)
                .font(.body)
                .foregroundStyle(.appGray3)
        }
        .tint(.appPurple)
    }
}

#Preview {
    AppDatePicker(date: .constant(Date()), title: "Title", components: [.date, .hourAndMinute])
}
