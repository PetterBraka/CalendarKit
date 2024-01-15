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
    let startDate: Date
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    public init(startDate: Date, range: ClosedRange<Date>, startOfWeek: ViewModel.Weekday) {
        self.viewModel = ViewModel(currentPage: 0, selectedDate: startDate, range: range)
        self.pageModels = []
        self.dateService = DateService()
        self.startDate = startDate
        
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
            updateViewModel(currentPage: page, selectedDate: date)
        case let .didSet(page):
            if (0 ... pageModels.count - 1).contains(page),
               let date = pageModels[page].dates.first(where: { $0.isThisMonth }) {
                updateViewModel(currentPage: page, selectedDate: date.date)
            }
        }
    }
}

private extension Presenter {
    func updateViewModel(currentPage: Int? = nil, 
                         selectedDate: Date? = nil,
                         range: ClosedRange<Date>? = nil) {
        viewModel = ViewModel(currentPage: currentPage ?? viewModel.currentPage,
                              selectedDate: selectedDate ?? viewModel.selectedDate,
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
        if startDate > viewModel.range.upperBound {
            perform(action: .didSet(page: pageModels.count - 1))
        }
    }
    
    func getRange() -> [(page: Int, month: Int, year: Int)] {
        let (thisYear, thisMonth) = dateService.getComponents(from: startDate)
        let (lowerYear, lowerMonth) = dateService.getComponents(from: viewModel.range.lowerBound)
        let (upperYear, upperMonth) = dateService.getComponents(from: viewModel.range.upperBound)

        let years = Array(lowerYear ... upperYear)
        let months = Array(1 ... 12)
        
        var monthsAndYears: [(page: Int, month: Int, year: Int)] = []
        var page = 0
        
        for year in years {
            for month in months {
                if lowerYear == year && month < lowerMonth {
                    continue
                }
                if month == thisMonth, year == thisYear {
                    updateViewModel(currentPage: page)
                }
                
                monthsAndYears.append((page, month, year))
                if upperYear == year && upperMonth == month {
                    return monthsAndYears
                }
                page += 1
            }
        }
        
        return monthsAndYears
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
                .compactMap { [weak self] date -> ViewModel.CalendarDate? in
                    guard let self else { return nil }
                    return ViewModel.CalendarDate(
                        date: date,
                        day: self.dateService.getDayComponent(from: date),
                        weekday: self.dateService.getWeekdayLabel(from: date),
                        isToday: self.dateService.isDateInToday(from: date),
                        isWeekday: self.dateService.isWeekday(date),
                        isThisMonth: self.dateService.isDate(inMonth: month, date)
                    )
                }
        )
    }
}
