//
//  CalendarView+init.swift
//  
//
//  Created by Petter vang Brakalsvålet on 11/12/2023.
//

import SwiftUI

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView, WeekdayLabelsBackground == EmptyView {
    init(month: Int,
         year: Int,
         startOfWeek: Weekday,
         onTap: @escaping (CalendarDate) -> Void) {
        self.init(month: month, year: year, startOfWeek: startOfWeek, customDayView: nil, customDayBackground: nil, customWeekdayLabelsBackground: nil, onTap: onTap)
    }
}
