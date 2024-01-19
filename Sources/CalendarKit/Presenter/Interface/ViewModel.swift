//
//  ViewModel.swift
//  
//
//  Created by Petter vang Brakalsvålet on 05/12/2023.
//

import Foundation

public struct ViewModel {
    public let currentPage: Int
    public let selectedDate: Date
    public let range: ClosedRange<Date>
}

extension ViewModel {
    public struct Page {
        public let pageIndex: Int
        public let month: Int
        public let year: Int
        public let title: String
        public let weekdays: [String]
        public let dates: [CalendarDate]
    }

    public struct CalendarDate: Hashable {
        public let date: Date
        public let day: Int
        public let isToday: Bool
        public let isWeekday: Bool
        public let isThisMonth: Bool
    }
}

extension Weekday {
    init(from weekday: Weekday) {
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
