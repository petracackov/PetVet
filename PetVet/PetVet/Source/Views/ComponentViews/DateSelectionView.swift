//
//  DateSelectionView.swift
//  PetVet
//
//  Created by Petra Cackov on 17/04/2022.
//

import SwiftUI

struct DateSelectionView: View {

    @Binding var selectedDate: Date
    @Binding var pickerIsShown: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Date of birth:")
                    .titleStyle()
                Button {
                    withAnimation {
                        pickerIsShown.toggle()
                    }
                } label: {
                    Text(selectedDate.formatted(date: .long, time: .omitted))
                        .foregroundColor(.petVet(.white))
                        .font(.ui.title)
                }
                .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                .frame(minWidth: 130, minHeight: 18)
                .background(
                    LinearGradient(colors: Appearance.Gradient.purple.colors, startPoint: .top, endPoint: .bottom)
                )
                .rounded()
            }

            if pickerIsShown {
                DatePicker("Enter your birthday", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .background(Color.ui.background)
                    .padding()
            }
        }
    }
}

struct DateSelectionView_Previews: PreviewProvider {
    @State static var date: Date = Date()
    @State static var pickerIsShown: Bool = true
    static var previews: some View {
        DateSelectionView(selectedDate: $date, pickerIsShown: $pickerIsShown)
    }
}
