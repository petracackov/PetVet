//
//  AppError.swift
//  PetVet
//
//  Created by Petra Cackov on 20/03/2022.
//

import Foundation

enum AppError: Error {

    case custom
    case serverError
    case noPermissions
    case doesNotExist
}
