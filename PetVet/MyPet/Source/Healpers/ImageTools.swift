//
//  ImageTools.swift
//  MyPet
//
//  Created by Petra Cackov on 13. 7. 24.
//

import UIKit

class ImageTools {
    
    static func convertImageToData(uiImage: UIImage?) throws -> Data {
        guard let image = uiImage else {
            throw AppError.noData
        }
        guard let pngData = image.pngData() else {
            throw AppError.noData
        }
        return pngData
    }
    
}
