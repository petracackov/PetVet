//
//  VetInfo.swift
//  MyPet
//
//  Created by Petra Cackov on 8. 8. 24.
//

import Foundation
import SwiftData

@Model 
class VetInfo: Identifiable {
    
    @Attribute(.unique) let id: String
    let name: String
    let vetName: String?
    let phoneNumber: [PhoneNumber]
    let email: String?
    let address: String?
    let webPage: String?
    
    init(id: String, name: String, vetName: String?, phoneNumber: [PhoneNumber], email: String?, address: String?, webPage: String?) {
        self.id = id
        self.name = name
        self.vetName = vetName
        self.phoneNumber = phoneNumber
        self.address = address
        self.webPage = webPage
        self.email = email
    }
    
    struct PhoneNumber: Identifiable, Codable {
        let id: String
        let numberType: NumberType
        let number: String
        
        enum NumberType: String, Codable {
            case mobile
            case home
        }
    }
    
}


