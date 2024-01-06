//
//  Presenter.swift
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
        
        setPages(startOfWeek: startOfWeek)
    }
    
    internal func perform(action: CalendarAction) {
        switch action {
        case let .didSetPageTo(date):
            let (year, month) = dateService.getComponents(from: date)
            guard let page = pageViewModels.firstIndex(where: {
                $0.year == year && $0.month == month
            })
            else { return }
            updateViewModel(currentPage: page)
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
        let thisMonth = calendar.component(.month, from: .now)
        let thisYear = calendar.component(.year, from: .now)
        
        var dateRange: [(month: Int, year: Int)] = []
        var date = viewModel.range.lowerBound
        var page = 0
        
        while date <= viewModel.range.upperBound {
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            dateRange.append((month, year))
            
            if month == thisMonth, year == thisYear {
                updateViewModel(currentPage: page)
            }
            
            guard let newDate = calendar.date(byAdding: .month, value: 1, to: date)
            else {
                return dateRange
            }
            
            page += 1
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
            month: month, year: year,
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
