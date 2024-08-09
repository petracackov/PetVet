//
//  ManageVetViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 8. 8. 24.
//

import Foundation

@Observable class ManageVetViewModel: ViewModel {
    
    let dataService: DataService
    let vetInfo: VetInfo?
    
    var name: String = ""
    var vetNames: [String] = []
    var phoneNumbers: [String] = []
    var emails: [String] = []
    var addresses: [String] = []
    var webPages: [String] = []
    
    var webPage: String? {
        guard webPages.count > 0 else { return nil }
        return webPages[0]
    }
    
    var isEditMode: Bool {
        vetInfo != nil
    }
    
    init(dataService: DataService, vetInfo: VetInfo? = nil) {
        self.dataService = dataService
        self.vetInfo = vetInfo
        
        super.init()
        initialSetup()
    }
    
    private func initialSetup() {
        guard let vetInfo else { return }
        
        name = vetInfo.name
        vetNames = [vetInfo.vetName].compactMap { $0 }
        phoneNumbers = vetInfo.phoneNumber.map { $0.number }
        emails = [vetInfo.email].compactMap { $0 }
        addresses = [vetInfo.address].compactMap { $0 }
        webPages = [vetInfo.webPage].compactMap { $0 }
    }
    
}
