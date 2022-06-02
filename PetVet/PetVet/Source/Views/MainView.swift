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
            case .error(let _): EmptyView() // TODO:
            case .data(let payload): petsView(pets: payload)
            }
        }

    }

    private func petsView(pets: [Pet]) -> some View {
        VStack {
            switch selectedTab {
            case .home:
                Text("TODO -> vet events")
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
    static var previews: some View {
        MainView()
    }
}

