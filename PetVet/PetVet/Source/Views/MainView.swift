//
//  MainView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct MainView: View {

    @ObservedObject var viewModel: MainVM = MainVM()
    @State var selectedTab: TabBarView.Tab = .home
    @State var showProfile: Bool = false
    @State var showPetCreationView: Bool = false
    @State var showUserProfileView: Bool = false

    var body: some View {
        CustomNavigationView {

            NavigationLink(
                destination: ProfileView(),
                isActive: $showProfile
            ) {
               EmptyView()
            }

            NavigationLink(
                destination: PetProfileCreationView(),
                isActive: $showPetCreationView
            ) {
               EmptyView()
            }

            NavigationLink(
                destination: ProfileView(),
                isActive: $showUserProfileView
            ) {
               EmptyView()
            }

            switch viewModel.state {
            case .undetermined: EmptyView()
            case .loading: ProgressView("Calling your pets...")
            case .error(let _): Text("Error") // TODO:
            case .data(let payload): petsView(pets: payload)
            }
        }

    }

    private func petsView(pets: [Pet]) -> some View {
        VStack {
            switch selectedTab {
            case .home:
                EventsView()
            case .pets:
                PetCarouselView(pets: pets)
            }
            Spacer()
            TabBarView(selectedTab: $selectedTab) {
                showPetCreationView = true
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("User Profile") {
                    showUserProfileView = true
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static let pets: [Pet] = [
        Pet(name: "teat", ownerId: "dfg", gender: .female, dateOfBirth: Date(), type: .cat, transponderCode: "12345678"),
        Pet(name: "teat", ownerId: "dfg", gender: .female, dateOfBirth: Date(), type: .cat, transponderCode: "12345678"),
        Pet(name: "teat", ownerId: "dfg", gender: .female, dateOfBirth: Date(), type: .cat, transponderCode: "12345678"),
        Pet(name: "teat", ownerId: "dfg", gender: .female, dateOfBirth: Date(), type: .cat, transponderCode: "12345678"),
    ]
    static var previews: some View {
        MainView(viewModel: MainVM(pets: pets))
    }
}

