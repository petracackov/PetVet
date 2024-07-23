//
//  EventsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import SwiftUI

@Observable class EventsViewModel: Cancelable {
    
    let dataService: DataService
    /// If pet is provided only events for that pet will be fetched
    let pet: Pet?
    var events: [PetEvent] = []
    
    var isPetView: Bool {
        pet != nil
    }
    
    /// For preview
    init(dataService: DataService, pet: Pet?, events: [PetEvent]) {
        self.pet = pet
        self.events = events
        self.dataService = dataService
        super.init()
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataService: DataService, pet: Pet? = nil) {
        self.init(dataService: dataService, pet: pet, events: [])
        
        fetchEvents()
        assignListeners()
    }
    
    func fetchEvents() {
        do {
            self.events = try dataService.fetchEvents(for: pet)
        } catch {
            AppError.handle(error)
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
            dataService.deleteEvent($0)
        }
    }
    
}
