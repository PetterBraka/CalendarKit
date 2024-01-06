//
//  ViewModel.swift
//  
//
//  Created by Petter vang Brakalsvålet on 05/12/2023.
//

import Foundation
import Engine

public struct ViewModel {
    public let currentPage: Int
    public let range: ClosedRange<Date>
}

extension ViewModel {
    public enum Weekday {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
    }
}

extension Engine.Weekday {
    init(from weekday: ViewModel.Weekday) {
        switch weekday {
        case .monday:
            self = .monday
        case .tuesday:
            self = .tuesday
        case .wednesday:
            self = .wednesday
        case .thursday:
            self = .thursday
        case .friday:
            self = .friday
        case .saturday:
            self = .saturday
        case .sunday:
            self = .sunday
        }
    }
}
