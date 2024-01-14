//
//  Array+Ext.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

import Foundation

extension Array where Element: Equatable {
    func rotate(toStartAt index: Index) -> [Element] {
        let index = self.index(startIndex, offsetBy: index, limitedBy: endIndex) ?? startIndex
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
}
