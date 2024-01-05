//
//  File.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/12/2023.
//

import Foundation

final class Presenter: PresenterType {
    public weak var scene: SceneType?
    private(set) var viewModels: [ViewModel] {
        didSet { scene?.perform(update: .viewModel) }
    }
    
    private var startOfWeek: Weekday
    private let calendar: Calendar = Calendar.current
    
    private let range: ClosedRange<Date>
    private var month: Int
    private var year: Int
    internal var currentPage: Int
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    internal init(startDate: Date, range: ClosedRange<Date>, startOfWeek: Weekday) {
        self.viewModels = []
        self.startOfWeek = startOfWeek
        
        self.range = range
        self.month = calendar.component(.month, from: startDate)
        self.year = calendar.component(.month, from: startDate)
        self.currentPage = 0
        
        setViewModel()
    }
    
    internal func perform(action: CalendarAction) {
        switch action {
        case .didAppear:
            break
        case .didTapToday:
            break
//            updateViewModel(
//                month: calendar.component(.month, from: .now),
//                year: calendar.component(.year, from: .now)
//            )
        }
    }
}

private extension Presenter {
    func setViewModel() {
        viewModels = getRange()
            .compactMap { [weak self] (month, year) in
                self?.initViewModel(month: month, year: year)
            }
    }
    
    func getRange() -> [(month: Int, year: Int)] {
        var dateRange: [(month: Int, year: Int)] = []
        var date = range.lowerBound
        var index = 0
        while date <= range.upperBound {
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            dateRange.append((month, year))
            guard let newDate = calendar.date(byAdding: .month, value: 1, to: date)
            else {
                return dateRange
            }
            index += 1
            if calendar.isDate(newDate, inSameDayAs: .now) {
                currentPage = index
            }
            date = newDate
        }
        return dateRange
    }
}

private extension Presenter {
    func initViewModel(month: Int, year: Int) -> ViewModel? {
        let startOfMonth = getStartOfMonth(month: month, year: year)
        guard let endOfMonth = getEndOfMonth(from: startOfMonth)
        else { return nil }
        
        let daysToAddBefore = getDaysToAddBefore(startOfMonth)
        let daysToAddAfter = getDaysToAddAfter(endOfMonth)
        guard let firstDate = calendar.date(byAdding: .day, value: -daysToAddBefore, to: startOfMonth),
              let lastDate = calendar.date(byAdding: .day, value: daysToAddAfter, to: endOfMonth)
        else { return nil }
        
        return ViewModel(
            title: formatter.string(from: startOfMonth),
            weekdays: getWeekdayLabels(),
            dates: generateDates(from: firstDate, to: lastDate)
                .map { [weak self] date -> ViewModel.CalendarDate in
                    ViewModel.CalendarDate(
                        date: date,
                        isToday: Calendar.current.isDateInToday(date),
                        isWeekday: self?.isWeekday(date) ?? false ,
                        isThisMonth: self?.isDate(inMonth: month, date) ?? false
                    )
                }
        )
    }
    
    func getWeekdayLabels() -> [String] {
        calendar.shortWeekdaySymbols
            .rotate(toStartAt: startOfWeek.number - 1)
    }
    
    func getStartOfMonth(month: Int, year: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: 1)
        return calendar.date(from: components) ?? Date()
    }
    
    func getEndOfMonth(from date: Date) -> Date? {
        calendar.date(byAdding: .init(month: 1, day: -1), to: date)
    }
    
    func getDaysToAddBefore(_ startOfMonth: Date) -> Int {
        let startWeekday = calendar.component(.weekday, from: startOfMonth)
        
        return (startWeekday - startOfWeek.number + 7) % 7
    }
    
    func getDaysToAddAfter(_ endOfMonth: Date) -> Int {
        let daysToAddAfter = calendar.component(.weekday, from: endOfMonth)
        let weekdayIndex = startOfWeek.number - 1
        return (7 - daysToAddAfter + weekdayIndex) % 7
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
