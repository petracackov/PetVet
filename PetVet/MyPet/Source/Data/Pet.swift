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
    var name: String
    @Attribute(.externalStorage, .allowsCloudEncryption) private var imageData: Data?
    private var speciesRaw: String
    
    var image: UIImage? {
        get {
            guard let imageData else { return UIImage(resource: species.image) }
            return UIImage(data: imageData) ?? UIImage(resource: species.image)
        } set {
            imageData = try? ImageTools.convertImageToData(uiImage: newValue)
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
    
    init(id: String, name: String, species: Species, image: UIImage?) {
        self.id = id
        self.name = name
        self.speciesRaw = species.rawValue
        self.image = image
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
