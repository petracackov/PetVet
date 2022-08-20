//
//  EventsVM.swift
//  PetVet
//
//  Created by Petra Cackov on 02/07/2022.
//

import Foundation

class EventsVM: LoadableViewModel<[Event], Any> {

    override init() {
        super.init()
        loadData()
    }

    func loadData() {
        Task {
            await injectState(.loading)
            do {
                let events = try await Event.getEvents()
                await injectState(.data(payload: events))
            } catch {
                // TODO
                await injectState(.error(payload: NSError()))
            }
        }
    }

    
    
}
