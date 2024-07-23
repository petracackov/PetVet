//
//  ManageEventsView.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import SwiftUI

struct ManageEventsView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: ManageEventsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            AppTextField(text: $viewModel.title, title: "Title")
            AppTextField(text: $viewModel.description, title: "Description")
            AppDatePicker(date: $viewModel.date, title: "Date of event:", components: [.date, .hourAndMinute])
            
            reminderTimePicker()
            
            if viewModel.isEditingMode {
                AppToggle(isOn: $viewModel.completed, title: "Compleated:")
            }
            
            Spacer()
            
            AppButton(title: "Save") {
                viewModel.save()
            }
        }
        .padding(20)
        .appGradient()
        .animation(.easeInOut, value: viewModel.addReminder)
        .animation(.easeInOut, value: viewModel.eventReminderTime)
        .navigationTitle(viewModel.isEditingMode ? "Edit event" : "Create event")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarItem(.systemIconTrash, isVisible: viewModel.isEditingMode) {
            viewModel.delete()
        }
        .toolbarItem(.systemIconChevronLeft, placement: .navigation) {
            navigation.navigationPath.removeLast()
        }
    }
    
    // TODO: cleanup
    private func reminderTimePicker() -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
            AppToggle(isOn: $viewModel.addReminder, title: "Add Reminder", description: "Reminds you of the event")
            
            if viewModel.addReminder {
                HStack {
                    VStack {
                        Picker("", selection: $viewModel.eventReminderTime) {
                            ForEach(ManageEventsViewModel.EventReminder.allCases) { event in
                                Text(event.rawValue)
                                    .tag(event)
                            }
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(.appPurpleLight)
                        
                        if viewModel.eventReminderTime == .custom {
                            AppDatePicker(date: $viewModel.remindMeOn, components: [.date, .hourAndMinute])
                        }
                    }
                        .padding(.vertical, 10)
                        
                    Spacer()
                }
            }
            
        }
       
    }

}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return ManageEventsView(viewModel: .init(dataService: dataService, petInfo: MockedData.eventPets.first!))
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return ManageEventsView(viewModel: .init(dataService: dataService, petInfo: MockedData.eventPets.first!, event: MockedData.events.first!))
}
