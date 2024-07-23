//
//  EventsView.swift
//  MyPet
//
//  Created by Petra Cackov on 15. 7. 24.
//

import SwiftUI

struct EventsView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @State var viewModel: EventsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.events) { event in
                EventCell(event: event,
                          showPet: !viewModel.isPetView,
                          isLast: viewModel.events.isLast(event),
                          isFirst: viewModel.events.isFirst(event))
                .asButton {
                    guard viewModel.isPetView else { return }
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
        .overlay {
            if viewModel.events.isEmpty {
                NoDataView(.events, title: "You have no upcoming events")
                    .padding(20)
            }
        }
        .navigationDestination(for: Navigation.EventsPath.self) { path in
            switch path {
            case .addEvent(let pet):
                ManageEventsView(viewModel: .init(dataSource: viewModel.dataSource, pet: pet))
            case .manageEvent(let event):
                //                    ManageEventsView(viewModel: .init(dataSource: viewModel.dataSource, pet: <#T##Pet#>, event: <#T##PetEvent?#>))
                EmptyView()
            }
        }
//        .animation(.easeInOut, value: viewModel.events)
        
    }
    
}

#Preview {
    let dataSource = DataSource()
    return EventsView(viewModel: .init(dataSource: dataSource,
                                pet: MockedData.pets.first!,
                                events: MockedData.events))
}

#Preview {
    let dataSource = DataSource()
    return EventsView(viewModel: .init(dataSource: dataSource,
                                pet: nil,
                                events: MockedData.events))
}

#Preview {
    let dataSource = DataSource()
    return EventsView(viewModel: .init(dataSource: dataSource,
                                pet: MockedData.pets.first!,
                                events: []))
}
