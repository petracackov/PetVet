//
//  NotificationManager.swift
//  MyPet
//
//  Created by Petra Cackov on 9. 7. 24.
//

import Foundation
import Combine


class NotificationManager {
    
    static let shared = NotificationManager()
    
    func publishersFor(_ types: [NotificationType]) -> [AnyPublisher<Void, Never>] {
        types.map { publisherFor($0) }
    }
    
    func publisherFor(_ type: NotificationType) -> AnyPublisher<Void, Never> {
       return NotificationCenter.default.publisher(for: type.name)
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
//    func addObserverFor(_ type: NotificationType, selector: Selector, observer: Any) {
//        NotificationCenter.default.addObserver(observer, selector: selector, name: type.name, object: nil)
//    }
    
    func postNotification(_ type: NotificationType, data: [String: Any]?) {
        NotificationCenter.default.post(name: type.name, object: nil)
        
    }
    
    enum NotificationType {
        
        case petUpdated
        case petAdded
        case petDeleted
        case medicalRecordAdded
        case medicalRecordUpdated
        case medicalRecordDeleted
        
        var name: Notification.Name {
            switch self {
            case .petUpdated: Notification.Name("petUpdated")
            case .petAdded: Notification.Name("petAdded")
            case .petDeleted: Notification.Name("petDeleted")
            case .medicalRecordAdded: Notification.Name("medicalRecordAdded")
            case .medicalRecordUpdated: Notification.Name("medicalRecordUpdated")
            case .medicalRecordDeleted: Notification.Name("medicalRecordDeleted")
            }
        }
    }
    
}

struct MedicalRecordNotificationId: CodableDataModel {
    let id: String
    let petId: String
}

struct PetNotificationId: CodableDataModel {
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
}

protocol CodableDataModel: Codable {
    
    init(data: [String: Any]) throws
    func dictionary() throws -> [String: Any]
    
}

extension CodableDataModel {
    
    init(data: [String: Any]) throws {
        let json = try JSONSerialization.data(withJSONObject: data)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Self.self, from: json)
        self = decoded
    }
    
    func dictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        if let json = try JSONSerialization.jsonObject(with: data) as? [String : Any] {
            return json
        } else {
            throw NSError()
        }

    }
}
