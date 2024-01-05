//
//  ViewModel.swift
//  
//
//  Created by Petter vang Brakalsvålet on 05/12/2023.
//

import Foundation

public struct ViewModel {
    let title: String
    let weekdays: [String]
    let dates: [CalendarDate]
}

extension ViewModel {
    public struct CalendarDate: Hashable {
        public let date: Date
        public let isToday: Bool
        public let isWeekday: Bool
        public let isThisMonth: Bool
    }
}
