//
//  CalendarKitTests.swift
//
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

@testable import CalendarKit
import TestingHelpers
import PageView
import XCTest
import SwiftUI

final class CalendarKitTests: XCTestCase {}

// MARK: - Init from startDate
extension CalendarKitTests {
    func test_default_startDateInit() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() },
                         customDayBackground: { _ in EmptyView() },
                         customWeekdayLabel: { _ in EmptyView() },
                         customMonthLabel: { _ in EmptyView() })
    }
    
    func test_default_init_startDate() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in })
    }
    
    func test_default_init_startDateCustomDayView() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() })
    }
    
    func test_default_init_startDateCustomDayBackground() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in },
                         customDayBackground: { _ in EmptyView() })
    }
    
    func test_default_init_startDateCustomWeekdayLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in },
                         customWeekdayLabel: { _ in EmptyView() })
    }
    
    func test_default_init_startDateCustomMonthLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in },
                         customMonthLabel: { _ in EmptyView() })
    }
    
    func test_default_init_startDateCustomDayViewWeekdayLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() },
                         customWeekdayLabel: { _ in EmptyView() })
    }
    
    func test_default_init_startDateCustomDayViewWeekdayLabelMonthLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() },
                         customWeekdayLabel: { _ in EmptyView() },
                         customMonthLabel: { _ in EmptyView() })
    }
    
    func test_default_init_startDateCustomDayViewDayBackgroundWeekdayLabelMonthLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(startDate: start,
                         range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal, 
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() },
                         customDayBackground: { _ in EmptyView() },
                         customWeekdayLabel: { _ in EmptyView() },
                         customMonthLabel: { _ in EmptyView() })
    }
}

// MARK: - Init from selectedDate
extension CalendarKitTests {
    func test_default_selectedDateInit() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in})
    }
    
    func test_default_selectedDateInitCustomDayBackground() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in },
                         customDayBackground: { _ in EmptyView() })
    }
    
    func test_default_selectedDateInitCustomWeekdayLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in },
                         customWeekdayLabel: { _ in EmptyView() })
    }
    
    func test_default_selectedDateInitCustomDayView() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() })
    }
    
    func test_default_selectedDateInitCustomMonthLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in },
                         customMonthLabel: { _ in EmptyView() })
    }
    
    func test_default_selectedDateInitCustomDayViewWeekdayLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() },
                         customWeekdayLabel: { _ in EmptyView() })
    }
    
    func test_default_selectedDateInitCustomDayViewWeekdayLabelMonthLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() },
                         customWeekdayLabel: { _ in EmptyView() },
                         customMonthLabel: { _ in EmptyView() })
    }
    
    func test_default_selectedDateInitCustomDayViewDayBackgroundWeekdayLabelMonthLabel() throws {
        let start = try Date(year: 2022, month: 1, day: 1)
        let end = try Date(year: 2024, month: 12, day: 1)
        _ = CalendarView(selectedDate: .constant(start),
                         range: start ... end,
                         startOfWeek: .monday,
                         onTap: { _ in },
                         customDayView: { _ in EmptyView() },
                         customDayBackground: { _ in EmptyView() },
                         customWeekdayLabel: { _ in EmptyView() },
                         customMonthLabel: { _ in EmptyView() })
    }
}

// MARK: - Observer
extension CalendarKitTests {
    func test_observer_performeUpdate_viewModel() {
        let observer = Observer(presenter: .init(
            startDate: .june_10_2018_Sunday,
            range: .june_10_2018_Sunday ... .february_1_2024_Thursday,
            startOfWeek: .monday
        ))
        observer.perform(update: .viewModel)
    }
    
    func test_observer_performeUpdate_pages() {
        let observer = Observer(presenter: .init(
            startDate: .june_10_2018_Sunday,
            range: .june_10_2018_Sunday ... .february_1_2024_Thursday,
            startOfWeek: .monday
        ))
        observer.perform(update: .pages)
    }
    
    func test_observer_performeAction_didSet() {
        let observer = Observer(presenter: .init(
            startDate: .june_10_2018_Sunday,
            range: .june_10_2018_Sunday ... .february_1_2024_Thursday,
            startOfWeek: .monday
        ))
        observer.perform(action: .didSet(page: 1))
    }
    
    func test_observer_performeAction_didSetPageTo() {
        let observer = Observer(presenter: .init(
            startDate: .june_10_2018_Sunday,
            range: .june_10_2018_Sunday ... .february_1_2024_Thursday,
            startOfWeek: .monday
        ))
        observer.perform(action: .didSetPageTo(date: .january_1_2024_Monday))
    }
}

// MARK: - Array extensions
extension CalendarKitTests {
    func test_array_chunkedInto3() {
        let array = [1,2,3,4,5,6,7,8,9,0]
        XCTAssertEqual(array.chunked(into: 3),
                       [[1,2,3],[4,5,6],[7,8,9],[0]])
    }
    
    func test_array_chunkedInt7() {
        let array = [1,2,3,4,5,6,7,8,9,0]
        XCTAssertEqual(array.chunked(into: 7),
                       [[1,2,3,4,5,6,7],[8,9,0]])
    }
}

// MARK: - Orientation map
extension CalendarKitTests {
    func test_orientation_InitFrom_vertical() {
        let orientation = PageOrientation(from: .vertical)
        XCTAssertEqual(orientation, .vertical)
    }
    
    func test_orientation_InitFrom_horizontal() {
        let orientation = PageOrientation(from: .horizontal)
        XCTAssertEqual(orientation, .horizontal)
    }
}
