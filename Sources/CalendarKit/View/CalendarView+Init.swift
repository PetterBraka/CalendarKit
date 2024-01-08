//
//  CalendarView+init.swift
//  
//
//  Created by Petter vang Brakalsvålet on 11/12/2023.
//

import SwiftUI
import Presenter

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView, WeekdayLabel == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                orientation: Orientation,
                onTap: @escaping (ViewModel.CalendarDate) -> Void) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayView == EmptyView, WeekdayLabel == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                orientation: Orientation,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayBackground: @escaping (ViewModel.CalendarDate) -> DayBackground) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  customDayView: nil, customDayBackground: customDayBackground,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                orientation: Orientation,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayBackground == EmptyView, WeekdayLabel == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                orientation: Orientation,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayView: @escaping (ViewModel.CalendarDate) -> DayView) {
        self.init(startDate: startDate, range: range, 
                  startOfWeek: startOfWeek, orientation: orientation,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayBackground == EmptyView {
    public init(startDate: Date = .now,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                orientation: Orientation,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayView: @escaping (ViewModel.CalendarDate) -> DayView,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(startDate: startDate, range: range,
                  startOfWeek: startOfWeek, orientation: orientation,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel,
                  onTap: onTap)
        
    }
}

// MARK: -

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView, WeekdayLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayView == EmptyView, WeekdayLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                orientation: Orientation,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayBackground: @escaping (ViewModel.CalendarDate) -> DayBackground) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  customDayView: nil, customDayBackground: customDayBackground,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayView == EmptyView, DayBackground == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  customDayView: nil, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayBackground == EmptyView, WeekdayLabel == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayView: @escaping (ViewModel.CalendarDate) -> DayView) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: nil,
                  onTap: onTap)
        
    }
}

extension CalendarView where DayBackground == EmptyView {
    public init(selectedDate: Binding<Date>,
                range: ClosedRange<Date>,
                startOfWeek: ViewModel.Weekday,
                onTap: @escaping (ViewModel.CalendarDate) -> Void,
                customDayView: @escaping (ViewModel.CalendarDate) -> DayView,
                customWeekdayLabel: @escaping (String) -> WeekdayLabel) {
        self.init(selectedDate: selectedDate, range: range, startOfWeek: startOfWeek,
                  customDayView: customDayView, customDayBackground: nil,
                  customWeekdayLabel: customWeekdayLabel,
                  onTap: onTap)
        
    }
}
