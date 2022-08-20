//
//  Array+extensions.swift
//  PetVet
//
//  Created by Petra Cackov on 20/08/2022.
//

import UIKit

extension Array where Element : Equatable {
    func isLast(element: Element) -> Bool {
        last == element
    }
}
