//
//  CalendarView+init.swift
//  
//
//  Created by Petter vang Brakalsvålet on 11/12/2023.
//

import SwiftUI

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView, WeekdayLabelsBackground == EmptyView {
    public init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         onTap: @escaping (CalendarDate) -> Void) {
        self.init(startDate: startDate, range: range, startOfWeek: startOfWeek,
                  customDayView: nil, customDayBackground: nil, customWeekdayLabelsBackground: nil,
                  onTap: onTap)
        
    }
}
