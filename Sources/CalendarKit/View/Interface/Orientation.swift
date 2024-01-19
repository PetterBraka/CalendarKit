//
//  Orientation.swift
//  
//
//  Created by Petter vang Brakalsvålet on 08/01/2024.
//

import PageView

public enum Orientation {
    case horizontal
    case vertical
}

extension PageOrientation {
    init(from orientation: Orientation) {
        switch orientation {
        case .horizontal:
            self = .horizontal
        case .vertical:
            self = .vertical
        }
    }
}
