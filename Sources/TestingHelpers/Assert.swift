//
//  File.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

import Foundation
import XCTest

public func assertDayIsSame(
    givenDate: Date, expectedDate: Date,
    calendar: Calendar = .init(identifier: .gregorian),
    file: StaticString = #file, line: UInt = #line
) {
    XCTAssertTrue(
        calendar.isDate(givenDate, inSameDayAs: expectedDate),
        file: file, line: line
    )
}
