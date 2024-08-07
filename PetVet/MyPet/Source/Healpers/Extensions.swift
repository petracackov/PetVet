//
//  Extensions.swift
//  MyPet
//
//  Created by Petra Cackov on 28. 6. 24.
//

import Foundation

extension Array where Element : Equatable {
    func isLast(_ element: Element) -> Bool {
        last == element
    }
    
    func isFirst(_ element: Element) -> Bool {
        first == element
    }
}

extension Date {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    var string: String {
        Self.dateFormatter.string(from: self)
    }
}


