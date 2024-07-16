//
//  ManageEventsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import Foundation

@Observable class ManageEventsViewModel {
    
    private let dataSource: DataSource
    private let pet: Pet
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
    
    init(dataSource: DataSource, pet: Pet, event: PetEvent? = nil) {
        self.dataSource = dataSource
        self.pet = pet
        self.event = event
        self.title = event?.title ?? ""
        self.description = event?.eventDescription ?? ""
        self.date = event?.date ?? Date()
        self.completed = event?.completed ?? false
    }
    
    func save() {
        if let event {
            event.title = title
            event.eventDescription = description
            event.date = date
            let notificationData = EventNotificationId(id: event.id, petId: event.petId)
            NotificationManager.shared.postNotification(.eventUpdated, data: try? notificationData.dictionary())
        } else if !title.isEmpty {
            let id = UUID().uuidString
            let event = PetEvent(id: id, title: title, eventDescription: description, date: date, petId: pet.id, completed: completed)
            dataSource.insert(event)
            let notificationData = PetNotificationId(id: id)
            NotificationManager.shared.postNotification(.eventAdded, data: try? notificationData.dictionary())
        } else {
            // TODO: handle error
            print("No data error")
        }
    }
    
    func delete() {
        guard let event else { return }
        dataSource.delete(event)
        let notificationData = try? EventNotificationId(id: event.id, petId: event.petId).dictionary()
        NotificationManager.shared.postNotification(.eventDeleted, data: notificationData)
    }
    
}
