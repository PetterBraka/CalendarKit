//
//  File.swift
//  
//
//  Created by Petter vang Brakalsvålet on 07/01/2024.
//

import Foundation

public extension Array where Element: Equatable {
    func uniqued() -> [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
