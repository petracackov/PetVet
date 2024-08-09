//
//  MyVetView.swift
//  MyPet
//
//  Created by Petra Cackov on 8. 8. 24.
//

import SwiftUI

struct MyVetView: View {
    
    @State var navigation = Navigation.shared
    @State var viewModel: MyVetViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.vets, content: vetCell)
            }
            
        }
        .toolbarItem(.systemIconPlus, isVisible: !viewModel.vets.isEmpty, action: {
            navigation.navigationPath.append(Navigation.VetsPath.addNewVet)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitle("My vet", isVisible: !viewModel.vets.isEmpty)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarItem(.systemIconChevronLeft, placement: .navigation) {
            navigation.navigationPath.removeLast()
        }
        .overlay {
            if viewModel.vets.isEmpty {
                NoDataView(.vets, title: "No Vets added") {
                    navigation.navigationPath.append(Navigation.VetsPath.addNewVet)
                }
                    .padding(70)
            }
        }
        .appGradient()
        .navigationDestination(for: Navigation.VetsPath.self) { path in
            switch path {
            case .addNewVet:
                ManageVetView(viewModel: .init(dataService: viewModel.dataService))
            case .manageVet(let info):
                ManageVetView(viewModel: .init(dataService: viewModel.dataService, vetInfo: info))
            }
        }
       
    }
    
    private func vetCell(vetInfo: VetInfo) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(vetInfo.name)
                    .font(.largeTitle)
                    .foregroundStyle(.appText)
                
                Spacer()
            }
            
            
            VStack(spacing: 15) {
                
                infoRow(.vetName, value: vetInfo.vetName)
                
                ForEach(vetInfo.phoneNumber) { phoneNumber in
                    infoRow(.phoneNumber, value: phoneNumber.number)
                }
                
                infoRow(.email, value: vetInfo.email)
                infoRow(.address, value: vetInfo.address)
                infoRow(.webPage, value: vetInfo.webPage)
                
                if let webPage = vetInfo.webPage, let url = URL(string: webPage) {
                    LinkPreview(urlString: webPage)
                }
            }
            
        }
        .padding()
        
    }
    
    @ViewBuilder
    private func infoRow(_ type: InfoRow, value: String?) -> some View {
        if let value {
            HStack {
                Text(type.title)
                    .font(.headline)
                Spacer()
                
                if let urlPrefix = type.urlPrefix, let url = URL(string: urlPrefix+value) {
                    Text(value)
                        .font(.body)
                        .foregroundStyle(type.color)
                        .asLink(destination: url)
                } else {
                    Text(value)
                        .font(.body)
                        .foregroundStyle(type.color)
                }
            }
        }
    }
    
    enum InfoRow {
        case phoneNumber
        case email
        case address
        case vetName
        case webPage
        
        var title: String {
            switch self {
            case .phoneNumber: "Tel:"
            case .email: "Email:"
            case .address: "Address:"
            case .vetName: "Vet:"
            case .webPage: "Web page"
            }
        }
        
        var urlPrefix: String? {
            switch self {
            case .phoneNumber: "tel:"
            case .email: "mailto:"
            case .webPage: ""
            case .address: "http://maps.apple.com/?address="
            case .vetName: nil
            }
        }
        
        var color: Color {
            switch self {
            case .webPage: .appPurpleLightDarkReverse
            case .vetName, .address, .email, .phoneNumber: .appText
            }
        }
    }
}

#Preview {
    let dataService = DataService(dataSource: DataSource.shared)
    return NavigationStack { MyVetView(viewModel: .init(dataService: dataService, vets: MockedData.vetInfo)) }
}

#Preview("No data") {
    let dataService = DataService(dataSource: DataSource.shared)
    return NavigationStack { MyVetView(viewModel: .init(dataService: dataService, vets: [])) }
}



