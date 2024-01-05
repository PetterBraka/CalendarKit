//
//  CalendarView+init.swift
//  
//
//  Created by Petter vang Brakalsvålet on 11/12/2023.
//

import SwiftUI

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView, WeekdayLabel == EmptyView {
    public init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         onTap: @escaping (CalendarDate) -> Void) {
        self.init(startDate: startDate, range: range, startOfWeek: startOfWeek,
                  customDayView: nil, customDayBackground: nil, 
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayView == EmptyView, WeekdayLabel == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (CalendarDate) -> Void,
                customDayBackground: @escaping (CalendarDate) -> DayBackground) {
        self.init(startDate: startDate, range: range, startOfWeek: startOfWeek,
                  customDayView: nil, customDayBackground: customDayBackground,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (CalendarDate) -> Void,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(startDate: startDate, range: range, startOfWeek: startOfWeek,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayBackground == EmptyView, WeekdayLabel == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (CalendarDate) -> Void,
                customDayView: @escaping (CalendarDate) -> DayView) {
        self.init(startDate: startDate, range: range, startOfWeek: startOfWeek,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayBackground == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (CalendarDate) -> Void,
                customDayView: @escaping (CalendarDate) -> DayView,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(startDate: startDate, range: range, startOfWeek: startOfWeek,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel,
                  onTap: onTap)
        
    }
}
