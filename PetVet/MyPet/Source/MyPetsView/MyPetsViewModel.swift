//
//  MyPetsViewModel.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import Foundation

enum DataState {
    case data([Pet])
    case oneItem(Pet)
    case empty
    case error(AppError)
    
    var items: [Pet] {
        switch self {
        case .data(let items): items
        case .oneItem(let item): [item]
        case .empty, .error: []
        }
    }
}

@Observable class MyPetsViewModel: ViewModel {
    
    let dataService: DataService
    private(set) var dataState: DataState
    var pets: [Pet] { dataState.items }
    var selectedPet: Pet?
    
    /// For preview
    init(pets: [Pet], dataService: DataService) {
        print("init", "MyPetsViewModel")
        self.dataState = Self.getDataState(pets)
        self.dataService = dataService
        super.init()
    }
    
    /// Fetches the data and assigns listeners
    convenience init(dataService: DataService) {
        print("init", "MyPetsViewModel")
        self.init(pets: [], dataService: dataService)
        
        fetchMyPets()
        assignListeners()
    }
    
    private static func getDataState(_ items: [Pet]) -> DataState {
        if items.isEmpty {
            return .empty
        } else if items.count == 1 {
            return .oneItem(items.first!)
        } else {
            return .data(items)
        }
    }
    
    func fetchMyPets() {
        do {
            let pets = try dataService.fetchMyPets()
            self.dataState = Self.getDataState(pets)
        } catch {
            handleError(error)
        }
    }
    
    override func handleError(_ error: (any Error)?) {
        super.handleError(error)
        guard let appError = self.error else { return }
        dataState = .error(appError)
    }
    
    private func assignListeners() {
        NotificationManager.shared.publishersFor([.petAdded, .petDeleted, .petUpdated])
            .forEach { publisher in
                publisher
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in
                        self?.fetchMyPets()
                    }
                    .store(in: &cancelable)
            }
    }
}
