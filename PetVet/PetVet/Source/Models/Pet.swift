//
//  Pet.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation
import UIKit
import Parse

class Pet: ParseObject, Identifiable {

    var id: String?
    var ownerId: String?
    var name: String?
    private var dateOfBirth: Date?
    var transponderCode: String?
    var transponderLocation: String?
    var image: UIImage?
    private var type: String?
    private var gender: String?

    var genderUi: Gender {
        guard let gender = gender else { return .male }
        return Gender.fromApiString(gender) ?? .male
    }

    var typeUi: PetType {
        guard let type = type else { return .other }
        return PetType.fromApiString(type) ?? .other
    }

    var dateOfBirthString: String {
        return "\(dateOfBirth ?? Date())"
    }

    override class var entityName: String { return "Pet" }

    init(name: String, ownerId: String, gender: Gender, dateOfBirth: Date, type: PetType, image: UIImage? = nil, transponderCode: String? = nil, transponderLocation: String? = nil) {
        self.name = name
        self.gender = gender.apiString
        self.dateOfBirth = dateOfBirth
        self.image = image
        self.transponderCode = transponderCode
        self.transponderLocation = transponderLocation
        self.id = UUID().uuidString
        self.ownerId = ownerId
        self.type = type.apiString
        super.init()
    }

    override init?(pfObject: PFObject?) {
        super.init(pfObject: pfObject)
    }

    override func generetePFObject() -> PFObject? {
        let item = super.generetePFObject()
        item?[Object.name.rawValue] = name
        item?[Object.ownerId.rawValue] = ownerId
        item?[Object.dateOfBirth.rawValue] = dateOfBirth
        item?[Object.gender.rawValue] = gender
        item?[Object.petType.rawValue] = type
        item?[Object.transponderCode.rawValue] = transponderCode == nil ? NSNull() : transponderCode
        item?[Object.transponderLocation.rawValue] = transponderLocation == nil ? NSNull() : transponderLocation
        //item?[Object.image.rawValue] = image
        return item
    }

    override func updateWithPFObject(_ object: PFObject) throws {
        try super.updateWithPFObject(object)
        guard let name = object[Object.name.rawValue] as? String,
              let objectId = object.objectId,
              let ownerId = object[Object.ownerId.rawValue] as? String,
              let dateOfBirth = object[Object.dateOfBirth.rawValue] as? Date,
              let gender = object[Object.gender.rawValue] as? String else {
                  throw NSError(domain: "ParseObject", code: 400, userInfo: ["dev_message": "Could not parse Task data from PFObject"])
              }

        self.name = name
        self.ownerId = ownerId
        self.id = objectId
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.transponderCode = object[Object.transponderCode.rawValue] as? String
        self.transponderLocation = object[Object.transponderLocation.rawValue] as? String
        self.type = object[Object.petType.rawValue] as? String
        //self.image = object[Object.image.rawValue] as UIImage?

    }

    static func generateQueryWithUserId(_ userId: String) -> PFQuery<PFObject>? {
        let query = generatePFQuery()
        query.whereKey(Object.ownerId.rawValue, equalTo: userId)
        return query
    }

}

extension Pet {
    private enum Object: String {
        case name
        case id = "objectId"
        case ownerId
        case dateOfBirth
        case transponderCode
        case transponderLocation
        case image
        case gender
        case petType
    }
}

// MARK: - Gender

extension Pet {

    enum Gender: CaseIterable {

        case male
        case female

        var index: Int { Gender.allCases.firstIndex(of: self) ?? 0 }

        var string: String {
            switch self {
            case .male: return "Male"
            case .female: return "Female"
            }
        }

        var apiString: String {
            switch self {
            case .male: return "male"
            case .female: return "female"
            }
        }

        var emoji: String {
            switch self {
            case .male: return "♂"
            case .female: return "♀"
            }
        }

        static func fromApiString(_ string: String) -> Gender? {
            Gender.allCases.first(where: { $0.apiString == string })
        }
    }

    enum PetType: String, CaseIterable, Identifiable {

        var id: Self { self }
        
        case cat
        case dog
        case fish
        case rodent
        case bird
        case reptile
        case insect
        case other

        var emoji: String {
            switch self {
            case .cat: return "🐈"
            case .dog: return "🐕"
            case .fish: return "🐠"
            case .rodent: return "🐁"
            case .bird: return "🦜"
            case .reptile: return "🦎"
            case .insect: return "🕷"
            case .other: return "🦥"
            }
        }

        var image: UIImage {
            switch self {
            case .cat: return R.image.catImage()!
            case .dog: return R.image.dogImage()!
            case .fish: return R.image.fishImage()!
            case .rodent: return R.image.rodentImage()!
            case .bird: return R.image.birdImage()!
            case .reptile: return R.image.reptileImage()!
            case .insect: return R.image.insectImage()!
            case .other: return R.image.platypusImage()!
            }
        }

        var apiString: String {
            return self.rawValue
        }

        var string: String {
            return self.rawValue.uppercased()
        }

        static func fromApiString(_ string: String) -> PetType? {
            PetType.allCases.first(where: { $0.apiString == string })
        }
    }

}
