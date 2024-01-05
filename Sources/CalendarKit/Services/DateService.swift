//
//  DateService.swift
//
//
//  Created by Petter vang Brakalsvålet on 05/01/2024.
//

import Foundation

public protocol DateServiceType {
    func getComponents(from date: Date) -> (year: Int, month: Int)
    func getWeekdayLabels(with startOfWeek: Weekday) -> [String]
    func getStartDate(of month: Int, _ year: Int, with startOfWeek: Weekday) -> Date?
    func getEndDate(from date: Date, with startOfWeek: Weekday) -> Date?
    func generateDates(from start: Date, to end: Date) -> [Date]
    func isDate(inMonth month: Int, _ date: Date) -> Bool
    func isWeekday(_ date: Date) -> Bool
}

final class DateService: DateServiceType {
    private let calendar: Calendar
    
    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }
    
    func getComponents(from date: Date) -> (year: Int, month: Int) {
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        return (year, month)
    }
    
    func getWeekdayLabels(with startOfWeek: Weekday) -> [String] {
        calendar.shortWeekdaySymbols
            .rotate(toStartAt: startOfWeek.number - 1)
    }
    
    func getDaysToAddBefore(_ startOfMonth: Date, with startOfWeek: Weekday) -> Int {
        let startWeekday = calendar.component(.weekday, from: startOfMonth)
        
        return (startWeekday - startOfWeek.number + 7) % 7
    }
    
    func getStartDate(of month: Int, _ year: Int, with startOfWeek: Weekday) -> Date? {
        let components = DateComponents(year: year, month: month, day: 1)
        guard let date = calendar.date(from: components)
        else { return nil }
        
        let daysToAddBefore = getDaysToAddBefore(date, with: startOfWeek)
        guard let startDate = calendar.date(byAdding: .day, value: -daysToAddBefore, to: date)
        else { return nil }
        return startDate
    }
    
    func getDaysToAddAfter(_ endOfMonth: Date, with startOfWeek: Weekday) -> Int {
        let daysToAddAfter = calendar.component(.weekday, from: endOfMonth)
        let weekdayIndex = startOfWeek.number - 1
        return (7 - daysToAddAfter + weekdayIndex) % 7
    }
    
    func getEndDate(from date: Date, with startOfWeek: Weekday) -> Date? {
        guard let date = calendar.date(byAdding: .init(month: 1, day: -1), to: date)
        else { return nil }
        let daysToAddAfter = getDaysToAddAfter(date, with: startOfWeek)
        guard let endDate = calendar.date(byAdding: .day, value: daysToAddAfter, to: date)
        else { return nil }
        return endDate
    }
    
    func generateDates(from start: Date, to end: Date) -> [Date] {
        var currentDate = start
        var resultDates: [Date] = []
        
        while currentDate <= end {
            resultDates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        return resultDates
    }
    
    func isDate(inMonth month: Int, _ date: Date) -> Bool {
        calendar.component(.month, from: date) == month
    }
    
    func isWeekday(_ date: Date) -> Bool {
        let weekday = calendar.component(.weekday, from: date)
        
        switch weekday {
        case Weekday.saturday.number,
            Weekday.sunday.number:
            return false
        default:
            return true
        }
    }
}
