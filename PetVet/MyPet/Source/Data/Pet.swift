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
    @Attribute(.externalStorage, .allowsCloudEncryption) var imageData: Data?
    private var speciesRaw: String
    
    var image: UIImage {
        guard let imageData else { return .nacho }
        return UIImage(data: imageData) ?? .nacho
    }
    var species: Species {
        get {
            Species(rawValue: speciesRaw) ?? .unknown
        }
        set {
            speciesRaw = newValue.rawValue
        }
    }
    
    init(id: String, name: String, species: Species, image: UIImage) {
        self.id = id
        self.name = name
        self.speciesRaw = species.rawValue
        self.imageData = try? ImageTools.convertImageToData(uiImage: image)
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

class ImageTools {
    
    static func convertImageToData(uiImage: UIImage?) throws -> Data {
        guard let image = uiImage else {
            // TODO
            throw NSError()
        }
        guard let pngData = image.pngData() else {
            throw NSError()
        }
        return pngData
    }
    
}
