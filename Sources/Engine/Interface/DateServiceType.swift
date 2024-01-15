//
//  DateServiceType.swift
//
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

import Foundation

public protocol DateServiceType {
    func getDayComponent(from date: Date) -> Int
    func getComponents(from date: Date) -> (year: Int, month: Int)
    func getWeekdayLabels(with startOfWeek: Weekday) -> [(short: String, long: String)]
    func getWeekdayLabel(from date: Date) -> String
    func getStartDate(of month: Int, _ year: Int, with startOfWeek: Weekday) -> Date?
    func getEndDate(from date: Date, with startOfWeek: Weekday) -> Date?
    func generateDates(from start: Date, to end: Date) -> [Date]
    func isDateInToday(from date: Date) -> Bool
    func isDate(inMonth month: Int, _ date: Date) -> Bool
    func isWeekday(_ date: Date) -> Bool
}
