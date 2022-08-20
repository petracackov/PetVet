//
//  EventsView.swift
//  PetVet
//
//  Created by Petra Cackov on 02/07/2022.
//

import SwiftUI

struct EventsView: View {

    @ObservedObject var viewModel: EventsVM = EventsVM()

    var body: some View {
        switch viewModel.state {
        case .data(let events): eventsView(events)
        case .loading: Text("TODO") // TODO
        case .error: Text("TODO") // TODO
        case .undetermined: Text("TODO") // TODO
        }
    }

    private func eventsView(_ events: [Event]) -> some View {
        List(events) { event in
            listItem(for: event, hasSeparator: !events.isLast(element: event))
                .listRowSeparator(.hidden)
        }
        .listStyle(.insetGrouped)
    }

    private func listItem(for event: Event, hasSeparator: Bool) -> some View {

        VStack {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(event.pet.typeUi.emoji)
                            .descriptionStyle()
                        Text(event.pet.name ?? "")
                            .descriptionStyle()
                    }

                    Text(event.title)
                        .titleStyle()
                    Text(event.description)
                        .descriptionStyle()
                }
                Spacer()

                Text(Date.extras._DefaultCalendar.formatter(.shortDateFormatter).string(from: event.eventDate))
                    .titleStyle()
            }
            .padding()
            if hasSeparator {
                Rectangle()
                    .frame(width: .infinity, height: 1)
                    .foregroundColor(.ui.backgroundGray)
            }
        }


    }

}

struct EventsView_Previews: PreviewProvider {

    static let viewModel = EventsVM()

    static var previews: some View {
        EventsView()
    }
}
