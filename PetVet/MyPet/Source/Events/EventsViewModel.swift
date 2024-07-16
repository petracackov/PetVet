//
//  EventsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import SwiftUI

@Observable class EventsViewModel: Cancelable {
    
    let dataSource: DataSource
    /// If pet is provided only events for that pet will be fetched
    let pet: Pet?
    var events: [PetEvent] = []
    
    var isPetView: Bool {
        pet != nil
    }
    
    /// For preview
    init(dataSource: DataSource, pet: Pet?, events: [PetEvent]) {
        self.pet = pet
        self.events = events
        self.dataSource = dataSource
        super.init()
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataSource: DataSource, pet: Pet? = nil) {
        self.init(dataSource: dataSource, pet: pet, events: [])
        
        fetchEvents()
        assignListeners()
    }
    
    func fetchEvents() {
        do {
            if let pet {
                let petId = pet.id
                self.events = try dataSource.fetch(type: PetEvent.self,
                                                   predicate: #Predicate { event in event.petId == petId },
                                                   sortBy: [SortDescriptor(\.date)])
            } else {
                self.events = try dataSource.fetch(type: PetEvent.self,
                                                   sortBy: [SortDescriptor(\.date)])
            }
        } catch {
            // TODO Handele rror
        }
    }
    
    private func assignListeners() {
        NotificationManager.shared.publishersFor([.eventAdded, .eventDeleted, .eventUpdated])
            .forEach { publisher in
                publisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.fetchEvents()
                    }
                    .store(in: &cancelable)
            }
    }
    
    func delete(at offsets: IndexSet) {
        let items = offsets.map { events[$0] }
        items.forEach {
            dataSource.delete($0)
            let notificationData = try? EventNotificationId(id: $0.id, petId: $0.petId).dictionary()
            NotificationManager.shared.postNotification(.eventDeleted, data: notificationData)
        }
        
    }
    
}
