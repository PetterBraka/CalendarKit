//
//  Orientation.swift
//
//
//  Created by Petter vang Brakalsvålet on 01/01/2024.
//

import UIKit

public enum Orientation {
    case horizontal
    case vertical
}

extension UIPageViewController.NavigationOrientation {
    init(from orientation: Orientation) {
        switch orientation {
        case .horizontal:
            self = .horizontal
        case .vertical:
            self = .vertical
        }
    }
}
