//
//  PageViewModel.swift
//
//
//  Created by Petter vang Brakalsvålet on 05/01/2024.
//

import Foundation

public struct PageViewModel {
    public let pageIndex: Int
    public let month: Int
    public let year: Int
    public let title: String
    public let weekdays: [String]
    public let dates: [CalendarDate]
}

extension PageViewModel {
    public struct CalendarDate: Hashable {
        public let date: Date
        public let isToday: Bool
        public let isWeekday: Bool
        public let isThisMonth: Bool
    }
}
