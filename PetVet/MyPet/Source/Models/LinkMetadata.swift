//
//  LinkMetadata.swift
//  MyPet
//
//  Created by Petra Cackov on 9. 8. 24.
//

import Foundation
import LinkPresentation

struct LinkMetadata {
    
    let urlString: String
    let metadata: LPLinkMetadata
    let title: String?
    let imageData: Data?
    let iconData: Data?
    
    var image: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
    
    var icon: UIImage? {
        guard let iconData else { return nil }
        return UIImage(data: iconData)
    }
    
}
