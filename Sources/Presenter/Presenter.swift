//
//  Presenter.swift
//
//
//  Created by Petter vang Brakalsvålet on 06/12/2023.
//

import Foundation
import Engine

public final class Presenter: PresenterType {
    public weak var scene: SceneType?
    
    private(set) public var viewModel: ViewModel {
        didSet { scene?.perform(update: .viewModel) }
    }
    private(set) public var pageModels: [ViewModel.Page] {
        didSet { scene?.perform(update: .pages) }
    }
    
    private let dateService: DateServiceType
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    public init(startDate: Date, range: ClosedRange<Date>, startOfWeek: ViewModel.Weekday) {
        self.viewModel = ViewModel(currentPage: 0, range: range)
        self.pageModels = []
        self.dateService = DateService()
        
        setPages(startOfWeek: startOfWeek)
    }
    
    public func perform(action: CalendarAction) {
        switch action {
        case let .didSetPageTo(date):
            let (year, month) = dateService.getComponents(from: date)
            guard let page = pageModels.firstIndex(where: {
                $0.year == year && $0.month == month
            })
            else { return }
            updateViewModel(currentPage: page)
        case let .didSet(page):
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
    func setPages(startOfWeek: ViewModel.Weekday) {
        pageModels = getRange()
            .compactMap { [weak self] (page, month, year) in
                self?.initPage(pageIndex: page,
                               month: month, year: year,
                               startOfWeek: .init(from: startOfWeek))
            }
    }
    
    func getRange() -> [(page: Int, month: Int, year: Int)] {
        let calendar = Calendar.current
        let thisMonth = calendar.component(.month, from: .now)
        let thisYear = calendar.component(.year, from: .now)
        
        var dateRange: [(page: Int, month: Int, year: Int)] = []
        var date = viewModel.range.lowerBound
        var page = 0
        
        while date <= viewModel.range.upperBound {
            let month = calendar.component(.month, from: date)
            let year = calendar.component(.year, from: date)
            dateRange.append((page, month, year))
            
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

    func initPage(pageIndex: Int, month: Int, year: Int, startOfWeek: Weekday) -> ViewModel.Page? {
        guard let date = Calendar.current.date(from: .init(year: year, month: month)),
              let firstDate = dateService.getStartDate(of: month, year, with: startOfWeek),
              let lastDate = dateService.getEndDate(from: firstDate, with: startOfWeek)
        else { return nil }
        
        return ViewModel.Page(
            pageIndex: pageIndex, month: month, year: year,
            title: formatter.string(from: date),
            weekdays: dateService.getWeekdayLabels(with: startOfWeek),
            dates: dateService.generateDates(from: firstDate, to: lastDate)
                .map { [weak self] date -> ViewModel.CalendarDate in
                        .init(
                            date: date,
                            isToday: Calendar.current.isDateInToday(date),
                            isWeekday: self?.dateService.isWeekday(date) ?? false ,
                            isThisMonth: self?.dateService.isDate(inMonth: month, date) ?? false
                        )
                }
        )
    }
}
