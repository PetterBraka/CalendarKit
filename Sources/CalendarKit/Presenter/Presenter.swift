//
//  File.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/12/2023.
//

import Foundation

final class Presenter: PresenterType {
    public weak var scene: SceneType?
    
    private(set) var viewModel: ViewModel {
        didSet { scene?.perform(update: .viewModel) }
    }
    private(set) var pageViewModels: [PageViewModel] {
        didSet { scene?.perform(update: .pages) }
    }
    
    private let dateService: DateServiceType
    
    private var month: Int
    private var year: Int
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    internal init(startDate: Date, range: ClosedRange<Date>, startOfWeek: Weekday) {
        self.viewModel = ViewModel(currentPage: 0, range: range)
        self.pageViewModels = []
        self.dateService = DateService()
        
        let (year, month) = dateService.getComponents(from: startDate)
        self.month = year
        self.year = month
        
        setPages(startOfWeek: startOfWeek)
    }
    
    internal func perform(action: CalendarAction) {
        switch action {
        case .didAppear:
            break
        case .didTapToday:
            break
        }
    }
}

private extension Presenter {
    func updateViewModel(currentPage: Int? = nil, range: ClosedRange<Date>? = nil) {
        viewModel = ViewModel(currentPage: currentPage ?? viewModel.currentPage,
                              range: range ?? viewModel.range)
    }
}

private extension Presenter {
    func setPages(startOfWeek: Weekday) {
        pageViewModels = getRange()
            .compactMap { [weak self] (month, year) in
                self?.initPage(month: month, year: year, startOfWeek: startOfWeek)
            }
    }
    
    func getRange() -> [(month: Int, year: Int)] {
        let calendar = Calendar.current
        var dateRange: [(month: Int, year: Int)] = []
        var date = viewModel.range.lowerBound
        var index = 0
        while date <= viewModel.range.upperBound {
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            dateRange.append((month, year))
            guard let newDate = calendar.date(byAdding: .month, value: 1, to: date)
            else {
                return dateRange
            }
            index += 1
            if calendar.isDate(newDate, inSameDayAs: .now) {
                updateViewModel(currentPage: index)
            }
            date = newDate
        }
        return dateRange
    }

    func initPage(month: Int, year: Int, startOfWeek: Weekday) -> PageViewModel? {
        guard let date = Calendar.current.date(from: .init(year: year, month: month)),
              let firstDate = dateService.getStartDate(of: month, year, with: startOfWeek),
              let lastDate = dateService.getEndDate(from: firstDate, with: startOfWeek)
        else { return nil }
        
        return PageViewModel(
            title: formatter.string(from: date),
            weekdays: dateService.getWeekdayLabels(with: startOfWeek),
            dates: dateService.generateDates(from: firstDate, to: lastDate)
                .map { [weak self] date -> CalendarDate in
                    CalendarDate(
                        date: date,
                        isToday: Calendar.current.isDateInToday(date),
                        isWeekday: self?.dateService.isWeekday(date) ?? false ,
                        isThisMonth: self?.dateService.isDate(inMonth: month, date) ?? false
                    )
                }
        )
    }
}
