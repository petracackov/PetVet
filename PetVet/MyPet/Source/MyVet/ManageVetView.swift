//
//  ManageVetView.swift
//  MyPet
//
//  Created by Petra Cackov on 8. 8. 24.
//

import SwiftUI

struct ManageVetView: View {
    
    @State var viewModel: ManageVetViewModel
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    AppTextField(text: $viewModel.name, title: "Name")
                        .padding(.bottom, 20)
                    AddTextFieldView(title: "Vet", maxFields: 1, values: $viewModel.vetNames)
                    AddTextFieldView(title: "Adress", maxFields: 1, values: $viewModel.addresses)
                    AddTextFieldView(title: "Phone number", maxFields: 5, values: $viewModel.phoneNumbers)
                    AddTextFieldView(title: "Email", maxFields: 5, values: $viewModel.emails)
                    AddTextFieldView(title: "Web Page", maxFields: 5, values: $viewModel.webPages)

                    if let webPage = viewModel.webPage {
                        LinkPreview(urlString: webPage)
                    }
                    
                }
            }
            AppButton(title: "Save") {
                print("Save")
            }
        }
        .padding()
        .appGradient()
        .navigationBarTitle(viewModel.isEditMode ? "Edit Vet" : "Create new vet")
        
    }
    
    
    
//    @ViewBuilder
//    private func emailRow() -> some View {
//        if viewModel.showEmailField {
//            HStack {
//                CircleEditIcon(type: .remove)
//                    .asButton {
//                        viewModel.showEmailField = false
//                    }
//                    .offset(y: 13)
//                AppTextField(text: $viewModel.email, title: "Email")
//            }
//        } else {
//            addButtonView(title: "Add email")
//                .asButton {
//                    viewModel.showEmailField = true
//                }
//        }
//    }
//    
//    @ViewBuilder
//    private func vetRow() -> some View {
//        if viewModel.showVetNameField {
//            HStack {
//                CircleEditIcon(type: .remove)
//                    .asButton {
//                        viewModel.showVetNameField = false
//                    }
//                    .offset(y: 13)
//                AppTextField(text: $viewModel.vetName, title: "Vet")
//            }
//        } else {
//            addButtonView(title: "Add vet")
//                .asButton {
//                    viewModel.showVetNameField = true
//                }
//        }
//    }
//    
//    @ViewBuilder
//    private func webPageRow() -> some View {
//        if viewModel.showWebPageField {
//            HStack {
//                CircleEditIcon(type: .remove)
//                    .asButton {
//                        viewModel.showWebPageField = false
//                    }
//                    .offset(y: 13)
//                AppTextField(text: $viewModel.webPage, title: "Web page")
//            }
//        } else {
//            addButtonView(title: "Add Web page")
//                .asButton {
//                    viewModel.showWebPageField = true
//                }
//        }
//    }
//    
//    @ViewBuilder
//    private func addressRow() -> some View {
//        if viewModel.showAddressField {
//            HStack {
//                VStack {
//                    Text("AA")
//                        .foregroundStyle(.clear)
//                        .font(.body)// to match the spacing of text field
//                    CircleEditIcon(type: .remove)
//                        .asButton {
//                            viewModel.showAddressField = false
//                        }
//                }
////                    .offset(y: 13)
//                AppTextField(text: $viewModel.address, title: "Address")
//            }
//        } else {
//            addButtonView(title: "Add Address")
//                .asButton {
//                    viewModel.showAddressField = true
//                }
//        }
//    }
    
    
}

#Preview("Edit") {
    let dataService = DataService(dataSource: DataSource.shared)
    return NavigationStack { ManageVetView(viewModel: .init(dataService: dataService, vetInfo: MockedData.vetInfo[0])) }
}

#Preview("Add new") {
    let dataService = DataService(dataSource: DataSource.shared)
    return NavigationStack { ManageVetView(viewModel: .init(dataService: dataService)) }
}
