//
//  ManageEventsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import Foundation

@Observable class ManageEventsViewModel {
    
    private let dataService: DataService
    private let petInfo: PetEvent.PetInfo
    private let event: PetEvent?
    
    var isEditingMode: Bool {
        event != nil
    }
    
    var title: String
    var description: String
    var date: Date
    var completed: Bool
    var addReminder: Bool = false
    var remindMeOn: Date = Date()
    var eventReminderTime: EventReminder = .onTheDayOfEvent
    
    enum EventReminder: String, CaseIterable, Identifiable {
        
        var id: Self { self}
        
        case onTheDayOfEvent = "Day of event"
        case custom = "Custom"
    }
    
    init(dataService: DataService, petInfo: PetEvent.PetInfo, event: PetEvent? = nil) {
        self.dataService = dataService
        self.petInfo = petInfo
        self.event = event
        self.title = event?.title ?? ""
        self.description = event?.eventDescription ?? ""
        self.date = event?.date ?? Date()
        self.completed = event?.completed ?? false
    }
    
    func save() {
        if let event {
            dataService.updateEvent(event, title: title, description: description, date: date, completed: completed)
        } else if !title.isEmpty {
            dataService.createEvent(for: petInfo, title: title, description: description, date: date, completed: completed)
        } else {
            AppError.handle(NSError())
        }
    }
    
    func delete() {
        guard let event else { return }
        dataService.deleteEvent(event)
    }
    
}
