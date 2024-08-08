//
//  AppError.swift
//  MyPet
//
//  Created by Petra Cackov on 23. 7. 24.
//

import Foundation

enum AppError: Error {
    case general(Error?)
    case noData
    case dataSource(Error)
    case validationFailed
    case parsingFailed
    case encodingFailed(Error)
    case decodingFailed(Error)
    case savingDataFailed
    
    var title: String {
        return "Error"
    }
    
    var description: String {
        switch self {
        case .dataSource: "Data could not be fetched."
        case .decodingFailed: "Decoding data failed"
        case .encodingFailed: "Encoding data failed."
        case .general: "Ups something went wrong."
        case .noData: "The data is empty"
        case .parsingFailed: "Parsing data failed"
        case .validationFailed: "Validation failed. There might be some data missing."
        case .savingDataFailed: "Data could not be saved"
        }
    }
}
