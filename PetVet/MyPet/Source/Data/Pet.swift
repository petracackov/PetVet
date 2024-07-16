//
//  Pet.swift
//  MyPet
//
//  Created by Petra Cackov on 27. 6. 24.
//

import SwiftData
import SwiftUI

@Model
class Pet: Identifiable, Hashable {
    
    @Attribute(.unique) let id: String
    @Attribute(.externalStorage, .allowsCloudEncryption) private var imageData: Data?
    var name: String
    var birthDate: Date
    private var speciesRaw: String
    private var genderRaw: String
    
    var image: UIImage? {
        get {
            guard let imageData else { return nil }
            return UIImage(data: imageData)
        } set {
            imageData = try? ImageTools.convertImageToData(uiImage: newValue)
        }
        
    }
    
    var gender: Gender {
        get {
            Gender(rawValue: genderRaw) ?? .unknown
        }
        set {
            genderRaw = newValue.rawValue
        }
    }
    
    var species: Species {
        get {
            Species(rawValue: speciesRaw) ?? .unknown
        }
        set {
            speciesRaw = newValue.rawValue
        }
    }
    
    init(id: String, name: String, species: Species, image: UIImage?, gender: Gender, birthDate: Date) {
        self.id = id
        self.name = name
        self.speciesRaw = species.rawValue
        self.genderRaw = gender.rawValue
        self.birthDate = birthDate
        self.image = image
    }
    
    enum Gender: String, CaseIterable, Identifiable {
        
        var id: Self { self }
        
        case male
        case female
        case unknown
    }
    
    enum Species: String, CaseIterable, Identifiable {
        
        var id: Self { self }
        
        case cat, dog, bird, snake, fish, insect, reptile, rodent, unknown
        
        var image: ImageResource {
            switch self {
            case .bird: .bird
            case .cat: .cat
            case .dog: .dog
            case .snake: .snake
            case .fish: .fish
            case .insect: .insect
            case .reptile: .reptile
            case .rodent: .rodent
            case .unknown: .platypus
            }
        }

    }
    
}

//struct PetUiModel {
//    
//    let id: String
//    let name: String
//    var image: UIImage?
//    var species: Pet.Species
//    
//    init(pet: Pet) {
//        id = pet.id
//        name = pet.name
//        image = pet.image
//        species = pet.species
//    }
//    
//    init(id: String, name: String, image: UIImage? = nil, species: Pet.Species) {
//        self.id = id
//        self.name = name
//        self.image = image
//        self.species = species
//    }
//    
//}
