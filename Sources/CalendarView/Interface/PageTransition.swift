//
//  PageTransition.swift
//  
//
//  Created by Petter vang Brakalsvålet on 01/01/2024.
//

import UIKit

public enum PageTransition {
    case scroll
    case pageCurl
}

extension UIPageViewController.TransitionStyle {
    init(from style: PageTransition) {
        switch style {
        case .scroll:
            self = .scroll
        case .pageCurl:
            self = .pageCurl
        }
    }
}
