//
//  MainView.swift
//  PetVet
//
//  Created by Petra Cackov on 19/03/2022.
//

import SwiftUI

struct MainView: View {

    //@State var menuIsShown: Bool = false
    @ObservedObject var viewModel: MainVM = MainVM()
    @State var selectedTab: TabBarView.Tab = .home

    var body: some View {
        CustomNavigationView {

            NavigationLink(
                destination: ProfileView(),
                isActive: $viewModel.showProfile
            ) {
               EmptyView()
            }

            NavigationLink(
                destination: PetProfileCreationView(),
                isActive: $viewModel.showPetCreationView
            ) {
               EmptyView()
            }

            NavigationLink(
                destination: ProfileView(),
                isActive: $viewModel.showUserProfileView
            ) {
               EmptyView()
            }

            if viewModel.isLoading {
                ProgressView("Calling your pets...")
            } else {
                VStack {
                    switch selectedTab {
                    case .home:
                        Text("TODO -> vet events")
                    case .pets:
                        PetCarouselView(pets: viewModel.pets)
                    }
                    Spacer()
                    TabBarView(selectedTab: $selectedTab) {
                        viewModel.showPetCreationView = true
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("User Profile") {
                            viewModel.showUserProfileView = true
                        }
                    }
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

