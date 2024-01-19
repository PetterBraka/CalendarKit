//
//  PresenterTests.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

@testable import CalendarKit
import TestingHelpers
import XCTest

final class PresenterTests: XCTestCase {
    var sut: Presenter!

    func setUpPresenter(startDate: Date, 
                        range: ClosedRange<Date>,
                        startOfWeek: Weekday) {
        sut = Presenter(startDate: startDate, range: range, startOfWeek: startOfWeek)
    }
}

// MARK: - inits
extension PresenterTests {
    func test_init_JanuaryToFebruary() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .monday
        )
        XCTAssertEqual(sut.viewModel.currentPage, 1)
        XCTAssertEqual(sut.viewModel.range, givenRange)
        XCTAssertEqual(sut.pageModels.count, 2)
        
        XCTAssertEqual(sut.pageModels.map(\.pageIndex), [0, 1])
        XCTAssertEqual(sut.pageModels.map(\.title), ["January 2024", "February 2024"])
        XCTAssertEqual(sut.pageModels.map(\.month), [1, 2])
        XCTAssertEqual(sut.pageModels.map(\.year), [2024, 2024])
        let givenWeekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        XCTAssertEqual(sut.pageModels.map(\.weekdays),Array(repeating: givenWeekdays, count: 2))
    }
    
    func test_init_2023To2024() throws {
        let givenRange = Date.january_1_2023_Sunday ... .january_1_2024_Monday
        setUpPresenter(
            startDate: .january_1_2024_Monday,
            range: givenRange,
            startOfWeek: .monday
        )
        XCTAssertEqual(sut.viewModel.currentPage, 12)
        XCTAssertEqual(sut.viewModel.range, givenRange)
        XCTAssertEqual(sut.pageModels.count, 13)
        
        XCTAssertEqual(sut.pageModels.map(\.pageIndex),
                       [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
        XCTAssertEqual(
            sut.pageModels.map(\.title),
            ["January 2023", "February 2023", "March 2023", "April 2023",
             "May 2023", "June 2023", "July 2023", "August 2023", "September 2023",
             "October 2023", "November 2023", "December 2023", "January 2024"]
        )
        XCTAssertEqual(sut.pageModels.map(\.month),
                       [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1])
        XCTAssertEqual(sut.pageModels.map(\.year),
                       Array(repeating: 2023, count: 12) + [2024])
        let givenWeekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        XCTAssertEqual(sut.pageModels.map(\.weekdays),Array(repeating: givenWeekdays, count: 13))
    }
    
    func test_init_1966To2024() throws {
        let givenRange = Date.november_3_1966_Thursday ... .january_1_2024_Monday
        setUpPresenter(
            startDate: .january_1_2023_Sunday,
            range: givenRange,
            startOfWeek: .monday
        )
        XCTAssertEqual(sut.viewModel.currentPage, 674)
        XCTAssertEqual(sut.viewModel.range, givenRange)
        XCTAssertEqual(sut.pageModels.count, 687)
        
        XCTAssertEqual(sut.pageModels.map(\.pageIndex), Array(0 ..< 687))
        let months = [11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        XCTAssertEqual(sut.pageModels.map(\.month).uniqued(), months)
        XCTAssertEqual(sut.pageModels.map(\.year).uniqued(),
                       [1966, 1967, 1968, 1969, 1970, 1971, 1972, 1973, 1974, 1975,
                        1976, 1977, 1978, 1979, 1980, 1981, 1982, 1983, 1984, 1985,
                        1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995,
                        1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005,
                        2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015,
                        2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024]
        )
        let givenWeekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(), givenWeekdays)
    }
    
    func test_init_JanuaryToFebruary_startDate_beforeRange() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_6_1994_Sunday,
            range: givenRange,
            startOfWeek: .monday
        )
        XCTAssertEqual(sut.viewModel.currentPage, 0)
        XCTAssertEqual(sut.viewModel.range, givenRange)
        XCTAssertEqual(sut.pageModels.count, 2)
        
        XCTAssertEqual(sut.pageModels.map(\.pageIndex), [0, 1])
        XCTAssertEqual(sut.pageModels.map(\.title), ["January 2024", "February 2024"])
        XCTAssertEqual(sut.pageModels.map(\.month), [1, 2])
        XCTAssertEqual(sut.pageModels.map(\.year), [2024, 2024])
        let givenWeekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        XCTAssertEqual(sut.pageModels.map(\.weekdays),Array(repeating: givenWeekdays, count: 2))
    }
    
    func test_init_2023To2024_startDate_pastRange() throws {
        let givenRange = Date.january_1_2023_Sunday ... .january_1_2024_Monday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .monday
        )
        XCTAssertEqual(sut.viewModel.currentPage, 12)
        XCTAssertEqual(sut.viewModel.range, givenRange)
        XCTAssertEqual(sut.pageModels.count, 13)
        
        XCTAssertEqual(sut.pageModels.map(\.pageIndex),
                       [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
        XCTAssertEqual(sut.pageModels.map(\.title),
                       ["January 2023", "February 2023", "March 2023", 
                        "April 2023", "May 2023", "June 2023", "July 2023",
                        "August 2023", "September 2023", "October 2023",
                        "November 2023", "December 2023", "January 2024"])
        XCTAssertEqual(sut.pageModels.map(\.month),
                       [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1])
        XCTAssertEqual(sut.pageModels.map(\.year), [2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023, 2023, 2024])
        let givenWeekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(), givenWeekdays)
    }
    
    func testPerformance_init() throws {
        measure {
            setUpPresenter(
                startDate: .january_1_2023_Sunday,
                range: .november_3_1966_Thursday ... .january_1_2024_Monday,
                startOfWeek: .monday
            )
        }
    }
}

// MARK: - Action didSet
extension PresenterTests {
    func test_performAction_didSet() {
        setUpPresenter(startDate: .february_6_1994_Sunday,
                       range: .february_6_1994_Sunday ... .december_8_2021_Wednesday,
                       startOfWeek: .monday)
        XCTAssertEqual(sut.viewModel.currentPage, 0)
        sut.perform(action: .didSet(page: 2))
        XCTAssertEqual(sut.viewModel.currentPage, 2)
    }
    
    func test_performAction_didSet_bellowZero() {
        setUpPresenter(startDate: .february_6_1994_Sunday,
                       range: .february_6_1994_Sunday ... .december_8_2021_Wednesday,
                       startOfWeek: .monday)
        XCTAssertEqual(sut.viewModel.currentPage, 0)
        sut.perform(action: .didSet(page: -2))
        XCTAssertEqual(sut.viewModel.currentPage, 0)
    }
    
    func test_performAction_didSet_pastMax() {
        setUpPresenter(startDate: .february_6_1994_Sunday,
                       range: .february_6_1994_Sunday ... .december_8_2021_Wednesday,
                       startOfWeek: .monday)
        XCTAssertEqual(sut.viewModel.currentPage, 0)
        sut.perform(action: .didSet(page: 100000))
        XCTAssertEqual(sut.viewModel.currentPage, 0)
    }
}

// MARK: - Action didSetPageTo
extension PresenterTests {
    func test_performAction_didSetPageTo() {
        setUpPresenter(startDate: .february_6_1994_Sunday,
                       range: .february_6_1994_Sunday ... .january_1_2023_Sunday,
                       startOfWeek: .monday)
        XCTAssertEqual(sut.viewModel.currentPage, 0)
        sut.perform(action: .didSetPageTo(date: .december_8_2021_Wednesday))
        XCTAssertEqual(sut.viewModel.currentPage, 334)
    }
    
    func test_performAction_didSetPageTo_bellowRange() {
        setUpPresenter(startDate: .february_6_1994_Sunday,
                       range: .february_6_1994_Sunday ... .january_1_2023_Sunday,
                       startOfWeek: .monday)
        XCTAssertEqual(sut.viewModel.currentPage, 0)
        sut.perform(action: .didSetPageTo(date: .november_3_1966_Thursday))
        XCTAssertEqual(sut.viewModel.currentPage, 0)
    }
    
    func test_performAction_didSetPageTo_aboveRange() {
        setUpPresenter(startDate: .february_6_1994_Sunday,
                       range: .february_6_1994_Sunday ... .january_1_2023_Sunday,
                       startOfWeek: .monday)
        XCTAssertEqual(sut.viewModel.currentPage, 0)
        sut.perform(action: .didSetPageTo(date: .january_1_2024_Monday))
        XCTAssertEqual(sut.viewModel.currentPage, 0)
    }
}

// MARK: - Tests to cover mapping
extension PresenterTests {
    func test_init_JanuaryToFebruary_tuesday() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .tuesday
        )
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(),
                       ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon"])
    }
    
    func test_init_JanuaryToFebruary_wednesday() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .wednesday
        )
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(),
                       ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue"])
    }
    
    func test_init_JanuaryToFebruary_thursday() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .thursday
        )
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(),
                       ["Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"])
    }
    
    func test_init_JanuaryToFebruary_friday() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .friday
        )
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(),
                       ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"])
    }
    
    func test_init_JanuaryToFebruary_saturday() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .saturday
        )
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(),
                       ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"])
    }
    
    func test_init_JanuaryToFebruary_sunday() throws {
        let givenRange = Date.january_1_2024_Monday ... .february_1_2024_Thursday
        setUpPresenter(
            startDate: .february_1_2024_Thursday,
            range: givenRange,
            startOfWeek: .sunday
        )
        XCTAssertEqual(sut.pageModels.flatMap(\.weekdays).uniqued(),
                       ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"])
    }
}
