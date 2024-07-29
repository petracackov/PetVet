//
//  EventsView.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import SwiftUI

struct EventsView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: EventsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.events) { event in
                EventCell(event: event,
                          isLast: viewModel.events.isLast(event),
                          isFirst: viewModel.events.isFirst(event), 
                          showPet: !viewModel.isPetView)
                .asButton {
                    navigation.navigationPath.append(Navigation.EventsPath.manageEvent(event))
                }
            }
            .onDelete(perform: viewModel.delete)
            .plainList()
            .padding(.horizontal, 20)
        }
        .listStyle(.plain)
        .background(.appBackground)
        .toolbarItem(.systemIconPlus, isVisible: viewModel.isPetView, action: {
            guard let pet = viewModel.pet else { return }
            navigation.navigationPath.append(Navigation.EventsPath.addEvent(pet))
        })
        .toolbarItem(.systemIconChevronLeft, placement: .navigation, isVisible: viewModel.isPetView) {
            navigation.navigationPath.removeLast()
        }
        .overlay {
            if viewModel.events.isEmpty {
                NoDataView(.events, title: "You have no upcoming events")
                    .padding(20)
            }
        }
        .navigationDestination(for: Navigation.EventsPath.self) { path in
            switch path {
            case .addEvent(let pet):
                ManageEventsView(viewModel: .init(dataService: viewModel.dataService, petInfo: .init(pet: pet)))
            case .manageEvent(let event):
                ManageEventsView(viewModel: .init(dataService: viewModel.dataService, petInfo: event.pet, event: event))
            }
        }
        
    }
    
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return EventsView(viewModel: .init(dataService: dataService,
                                pet: MockedData.pets.first!,
                                events: MockedData.events))
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return EventsView(viewModel: .init(dataService: dataService,
                                pet: nil,
                                events: MockedData.events))
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return EventsView(viewModel: .init(dataService: dataService,
                                pet: MockedData.pets.first!,
                                events: []))
}
