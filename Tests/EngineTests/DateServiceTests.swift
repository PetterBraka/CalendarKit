//
//  DateServiceTests.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

@testable import Engine
import TestingHelpers
import XCTest

final class DateServiceTests: XCTestCase {
    var sut: DateServiceType!
    
    override func setUp() {
        sut = DateService(calendar: .init(identifier: .gregorian))
    }
}

// MARK: - test_getComponents
extension DateServiceTests {
    func test_getComponents_january_1_2024_Monday() {
        let components = sut.getComponents(from: .january_1_2024_Monday)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.year, 2024)
    }
    
    func test_getComponents_january_10_2024_Wednesday() {
        let components = sut.getComponents(from: .january_10_2024_Wednesday)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.year, 2024)
    }
    
    func test_getComponents_february_6_1994_Sunday() {
        let components = sut.getComponents(from: .february_6_1994_Sunday)
        XCTAssertEqual(components.month, 2)
        XCTAssertEqual(components.year, 1994)
    }
    
    func test_getComponents_march_5_1970_Thursday() {
        let components = sut.getComponents(from: .march_5_1970_Thursday)
        XCTAssertEqual(components.month, 3)
        XCTAssertEqual(components.year, 1970)
    }
    
    func test_getComponents_march_7_1994_Monday() {
        let components = sut.getComponents(from: .march_7_1994_Monday)
        XCTAssertEqual(components.month, 3)
        XCTAssertEqual(components.year, 1994)
    }
    
    func test_getComponents_may_2_1999_Sunday() {
        let components = sut.getComponents(from: .may_2_1999_Sunday)
        XCTAssertEqual(components.month, 5)
        XCTAssertEqual(components.year, 1999)
    }
    
    func test_getComponents_june_10_2018_Sunday() {
        let components = sut.getComponents(from: .june_10_2018_Sunday)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.year, 2018)
    }
    
    func test_getComponents_november_3_1966_Thursday() {
        let components = sut.getComponents(from: .november_3_1966_Thursday)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.year, 1966)
    }
    
    func test_getComponents_december_8_2021_Wednesday() {
        let components = sut.getComponents(from: .december_8_2021_Wednesday)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.year, 2021)
    }
}

// MARK: - test_getWeekdayLabels
extension DateServiceTests {
    func test_getWeekdayLabels_sunday() {
        let weekdays = sut.getWeekdayLabels(with: .sunday)
        XCTAssertEqual(weekdays, [
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat",
        ])
    }
    
    func test_getWeekdayLabels_monday() {
        let weekdays = sut.getWeekdayLabels(with: .monday)
        XCTAssertEqual(weekdays, [
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat",
            "Sun",
        ])
    }
    
    func test_getWeekdayLabels_tuesday() {
        let weekdays = sut.getWeekdayLabels(with: .tuesday)
        XCTAssertEqual(weekdays, [
            "Tue",
            "Wed",
            "Thu",
            "Fri",
            "Sat",
            "Sun",
            "Mon",
        ])
    }
    
    func test_getWeekdayLabels_wednesday() {
        let weekdays = sut.getWeekdayLabels(with: .wednesday)
        XCTAssertEqual(weekdays, [
            "Wed",
            "Thu",
            "Fri",
            "Sat",
            "Sun",
            "Mon",
            "Tue",
        ])
    }
    
    func test_getWeekdayLabels_thursday() {
        let weekdays = sut.getWeekdayLabels(with: .thursday)
        XCTAssertEqual(weekdays, [
            "Thu",
            "Fri",
            "Sat",
            "Sun",
            "Mon",
            "Tue",
            "Wed",
        ])
    }
    
    func test_getWeekdayLabels_friday() {
        let weekdays = sut.getWeekdayLabels(with: .friday)
        XCTAssertEqual(weekdays, [
            "Fri",
            "Sat",
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
        ])
    }
    
    func test_getWeekdayLabels_saturday() {
        let weekdays = sut.getWeekdayLabels(with: .saturday)
        XCTAssertEqual(weekdays, [
            "Sat",
            "Sun",
            "Mon",
            "Tue",
            "Wed",
            "Thu",
            "Fri",
        ])
    }
}

// MARK: - test_getStartDate
extension DateServiceTests {
    func test_getStartDateJan2024Sunday() throws {
        XCTAssertEqual(
            try XCTUnwrap(sut.getStartDate(of: 1, 2024, with: .sunday)),
            try Date(year: 2023, month: 12, day: 31)
        )
    }
    
    func test_getStartDateJan2024Saturday() throws {
        XCTAssertEqual(
            try XCTUnwrap(sut.getStartDate(of: 1, 2024, with: .saturday)),
            try Date(year: 2023, month: 12, day: 30)
        )
    }
    
    func test_getStartDateJan2024Friday() throws {
        XCTAssertEqual(
            try XCTUnwrap(sut.getStartDate(of: 1, 2024, with: .friday)),
            try Date(year: 2023, month: 12, day: 29)
        )
    }
    
    func test_getStartDateJan2024Thursday() throws {
        XCTAssertEqual(
            try XCTUnwrap(sut.getStartDate(of: 1, 2024, with: .thursday)),
            try Date(year: 2023, month: 12, day: 28)
        )
    }
    
    func test_getStartDateJan2024Wednesday() throws {
        XCTAssertEqual(
            try XCTUnwrap(sut.getStartDate(of: 1, 2024, with: .wednesday)),
            try Date(year: 2023, month: 12, day: 27)
        )
    }
    
    func test_getStartDateJan2024Tuesday() throws {
        XCTAssertEqual(
            try XCTUnwrap(sut.getStartDate(of: 1, 2024, with: .tuesday)),
            try Date(year: 2023, month: 12, day: 26)
        )
    }
    
    func test_getStartDateJan2024Monday() throws {
        XCTAssertEqual(
            try XCTUnwrap(sut.getStartDate(of: 1, 2024, with: .monday)),
            try Date(year: 2024, month: 1, day: 1)
        )
    }
}

// MARK: - test_getEndDate
extension DateServiceTests {
    func test_getEndDate_january_1_2024_Monday_sunday() {
        XCTAssertEqual(
            sut.getEndDate(from: .january_1_2024_Monday, with: .sunday),
            try Date(year: 2024, month: 2, day: 4)
        )
    }
    
    func test_getEndDate_january_1_2024_Monday_saturday() {
        XCTAssertEqual(
            sut.getEndDate(from: .january_1_2024_Monday, with: .saturday),
            try Date(year: 2024, month: 2, day: 3)
        )
    }
    
    func test_getEndDate_january_1_2024_Monday_friday() {
        XCTAssertEqual(
            sut.getEndDate(from: .january_1_2024_Monday, with: .friday),
            try Date(year: 2024, month: 2, day: 2)
        )
    }
    
    func test_getEndDate_january_1_2024_Monday_thursday() {
        XCTAssertEqual(
            sut.getEndDate(from: .january_1_2024_Monday, with: .thursday),
            try Date(year: 2024, month: 2, day: 1)
        )
    }
    
    func test_getEndDate_january_1_2024_Monday_wednesday() {
        XCTAssertEqual(
            sut.getEndDate(from: .january_1_2024_Monday, with: .wednesday),
            try Date(year: 2024, month: 1, day: 31)
        )
    }
    
    func test_getEndDate_january_1_2024_Monday_tuesday() {
        XCTAssertEqual(
            sut.getEndDate(from: .january_1_2024_Monday, with: .tuesday),
            try Date(year: 2024, month: 2, day: 6)
        )
    }
    
    func test_getEndDate_january_1_2024_Monday_monday() {
        XCTAssertEqual(
            sut.getEndDate(from: .january_1_2024_Monday, with: .monday),
            try Date(year: 2024, month: 2, day: 5)
        )
    }
}

// MARK: - test_isWeekday
extension DateServiceTests {
    func test_isWeekday_february_6_1994_Sunday() {
        XCTAssertEqual(sut.isWeekday(.february_6_1994_Sunday), false)
    }
    
    func test_isWeekday_january_13_2024_saturday() {
        XCTAssertEqual(sut.isWeekday(.january_13_2024_Saturday), false)
    }
    
    func test_isWeekday_january_12_2024_friday() {
        XCTAssertEqual(sut.isWeekday(.january_12_2024_Friday), true)
    }
    
    func test_isWeekday_march_5_1970_Thursday() {
        XCTAssertEqual(sut.isWeekday(.march_5_1970_Thursday), true)
    }
    
    func test_isWeekday_december_8_2021_Wednesday() {
        XCTAssertEqual(sut.isWeekday(.december_8_2021_Wednesday), true)
    }
    
    func test_isWeekday_january_9_2024_Tuesday() {
        XCTAssertEqual(sut.isWeekday(.january_9_2024_Tuesday), true)
    }
    
    func test_isWeekday_march_7_1994_Monday() {
        XCTAssertEqual(sut.isWeekday(.march_7_1994_Monday), true)
    }
}

// MARK: - test_isDateInMonth
extension DateServiceTests {
    func test_isDateInMonth_january() {
        let month = 1
        XCTAssertEqual(sut.isDate(inMonth: month, .january_12_2024_Friday), true)
        XCTAssertEqual(sut.isDate(inMonth: month, .february_6_1994_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .march_7_1994_Monday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .may_2_1999_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .june_10_2018_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .november_3_1966_Thursday), false)
    }
    
    func test_isDateInMonth_february() {
        let month = 2
        XCTAssertEqual(sut.isDate(inMonth: month, .january_12_2024_Friday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .february_6_1994_Sunday), true)
        XCTAssertEqual(sut.isDate(inMonth: month, .march_7_1994_Monday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .may_2_1999_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .june_10_2018_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .november_3_1966_Thursday), false)
    }
    
    func test_isDateInMonth_march() {
        let month = 3
        XCTAssertEqual(sut.isDate(inMonth: month, .january_12_2024_Friday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .february_6_1994_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .march_7_1994_Monday), true)
        XCTAssertEqual(sut.isDate(inMonth: month, .may_2_1999_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .june_10_2018_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .november_3_1966_Thursday), false)
    }
    
    func test_isDateInMonth_may() {
        let month = 5
        XCTAssertEqual(sut.isDate(inMonth: month, .january_12_2024_Friday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .february_6_1994_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .march_7_1994_Monday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .may_2_1999_Sunday), true)
        XCTAssertEqual(sut.isDate(inMonth: month, .june_10_2018_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .november_3_1966_Thursday), false)
    }
    
    func test_isDateInMonth_june() {
        let month = 6
        XCTAssertEqual(sut.isDate(inMonth: month, .january_12_2024_Friday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .february_6_1994_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .march_7_1994_Monday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .may_2_1999_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .june_10_2018_Sunday), true)
        XCTAssertEqual(sut.isDate(inMonth: month, .november_3_1966_Thursday), false)
    }
    
    func test_isDateInMonth_november() {
        let month = 11
        XCTAssertEqual(sut.isDate(inMonth: month, .january_12_2024_Friday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .february_6_1994_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .march_7_1994_Monday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .may_2_1999_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .june_10_2018_Sunday), false)
        XCTAssertEqual(sut.isDate(inMonth: month, .november_3_1966_Thursday), true)
    }
}

// MARK: - test_generateDates
extension DateServiceTests {
    func test_generateDates_january_1_2024_Monday_to_january_14_2024_Sunday() {
        let days = sut.generateDates(from: .january_1_2024_Monday,
                                     to: .january_14_2024_Sunday)
        XCTAssertEqual(days.count, 14)
    }
    
    func test_generateDates_january_1_2024_Monday_to_december_8_2021_Wednesday() {
        let days = sut.generateDates(from: .january_1_2024_Monday,
                                     to: .december_8_2021_Wednesday)
        XCTAssertEqual(days.count, 0)
    }
    
    func test_generateDates_december_8_2021_Wednesday_to_january_1_2024_Monday() {
        let days = sut.generateDates(from: .december_8_2021_Wednesday,
                                     to: .january_1_2024_Monday)
        XCTAssertEqual(days.count, 755)
    }
    
    func test_performance_generateDates_1Year() throws {
        let calendar = Calendar(identifier: .gregorian)
        let date = try XCTUnwrap(
            calendar.date(byAdding: .year,value: -1,to: .january_1_2024_Monday)
        )
        measure {
            _ = sut.generateDates(from: date, to: .january_1_2024_Monday)
        }
    }
    
    func test_performance_generateDates_10Years() throws {
        let calendar = Calendar(identifier: .gregorian)
        let date = try XCTUnwrap(
            calendar.date(byAdding: .year,value: -10,to: .january_1_2024_Monday)
        )
        measure {
            _ = sut.generateDates(from: date, to: .january_1_2024_Monday)
        }
    }
    
    func test_performance_generateDates_100Years() throws {
        let calendar = Calendar(identifier: .gregorian)
        let date = try XCTUnwrap(
            calendar.date(byAdding: .year,value: -100,to: .january_1_2024_Monday)
        )
        measure {
            _ = sut.generateDates(from: date, to: .january_1_2024_Monday)
        }
    }
}
