//
//  ParseManager.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation
import Parse

class ParseManager {

    static func initialize() {
        Parse.initialize(with: ParseManager.configuration)
    }

    private static let configuration = ParseClientConfiguration {
        $0.applicationId = "xkZfzzc9LICRnjsNAs0VKRjdhIwryHDkdBuJiBB2"
        $0.clientKey = "njD5rqbr4Zw6ekMF33pVWVT3AY2rVSeAoMIxNGvN"
        $0.server = "https://parseapi.back4app.com"
    }
}
