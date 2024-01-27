//
//  CalendarView+init.swift
//
//
//  Created by Petter vang Brakalsvålet on 11/12/2023.
//

import SwiftUI

// MARK: - startDate
extension CalendarView where DayView == EmptyView, DayBackground == EmptyView,
                             WeekdayLabel == EmptyView, MonthLabel == EmptyView {
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         orientation: Orientation,
         onTap: @escaping (ViewModel.CalendarDate) -> Void) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: nil, customMonthLabel: nil)
        
    }
}

extension CalendarView where DayView == EmptyView, WeekdayLabel == EmptyView, MonthLabel == EmptyView {
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         orientation: Orientation,
         onTap: @escaping (ViewModel.CalendarDate) -> Void,
         customDayBackground: @escaping (ViewModel.CalendarDate) -> DayBackground) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: customDayBackground,
                  customWeekdayLabel: nil, customMonthLabel: nil)
        
    }
}

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView, MonthLabel == EmptyView {
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         orientation: Orientation,
         onTap: @escaping (ViewModel.CalendarDate) -> Void,
         customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel,
                  customMonthLabel: nil)
        
    }
}

extension CalendarView where DayBackground == EmptyView, WeekdayLabel == EmptyView, MonthLabel == EmptyView {
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         orientation: Orientation,
         onTap: @escaping (ViewModel.CalendarDate) -> Void,
         customDayView: @escaping (ViewModel.CalendarDate) -> DayView) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  onTap: onTap,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: nil, customMonthLabel: nil)
        
    }
}

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView, WeekdayLabel == EmptyView {
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         orientation: Orientation,
         onTap: @escaping (ViewModel.CalendarDate) -> Void,
         customMonthLabel: @escaping (String) -> MonthLabel) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: nil, customMonthLabel: customMonthLabel)
        
    }
}

extension CalendarView where DayBackground == EmptyView, MonthLabel == EmptyView {
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         orientation: Orientation,
         onTap: @escaping (ViewModel.CalendarDate) -> Void,
         customDayView: @escaping (ViewModel.CalendarDate) -> DayView,
         customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  onTap: onTap,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel, customMonthLabel: nil)
        
    }
}

extension CalendarView where DayBackground == EmptyView {
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         orientation: Orientation,
         onTap: @escaping (ViewModel.CalendarDate) -> Void,
         customDayView: @escaping (ViewModel.CalendarDate) -> DayView,
         customWeekdayLabel: @escaping (String) -> WeekdayLabel,
         customMonthLabel: @escaping (String) -> MonthLabel) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  onTap: onTap,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel, customMonthLabel: customMonthLabel)
    }
}

// MARK: - selectedDate

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView,
                             WeekdayLabel == EmptyView, MonthLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: nil, customMonthLabel: nil)
    }
}

extension CalendarView where DayView == EmptyView, WeekdayLabel == EmptyView,
                             MonthLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayBackground: @escaping (ViewModel.CalendarDate) -> DayBackground) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: customDayBackground,
                  customWeekdayLabel: nil, customMonthLabel: nil)
    }
}

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView,
                             MonthLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel, customMonthLabel: nil)
    }
}

extension CalendarView where DayBackground == EmptyView, WeekdayLabel == EmptyView,
                             MonthLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayView: @escaping (ViewModel.CalendarDate) -> DayView) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  onTap: onTap,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: nil, customMonthLabel: nil)
    }
}

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView,
                             WeekdayLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customMonthLabel: @escaping (String) -> MonthLabel) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  onTap: onTap,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: nil, customMonthLabel: customMonthLabel)
    }
}

extension CalendarView where DayBackground == EmptyView, MonthLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayView: @escaping (ViewModel.CalendarDate) -> DayView,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  onTap: onTap,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel, customMonthLabel: nil)
    }
}

extension CalendarView where DayBackground == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayView: @escaping (ViewModel.CalendarDate) -> DayView,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel,
                customMonthLabel: @escaping (String) -> MonthLabel) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  onTap: onTap,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel, customMonthLabel: customMonthLabel)
    }
}
