//
//  ViewModel.swift
//  
//
//  Created by Petter vang Brakalsvålet on 05/12/2023.
//

import Foundation

struct ViewModel {
    let title: String
    let weekdays: [String]
    let dates: [CalendarDate]
}

extension ViewModel {
    struct CalendarDate: Hashable {
        let date: Date
        let isToday: Bool
        let isWeekday: Bool
        let isThisMonth: Bool
    }
}
