//
//  File.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

import Foundation
import XCTest

public extension Date {
    static let february_6_1994_Sunday = Date(timeIntervalSince1970: 760492800)
    static let march_5_1970_Thursday = Date(timeIntervalSince1970: 5443200)
    static let march_7_1994_Monday = Date(timeIntervalSince1970: 762998400)
    static let may_2_1999_Sunday = Date(timeIntervalSince1970: 925603200)
    static let june_10_2018_Sunday = Date(timeIntervalSince1970: 1528588800)
    static let november_3_1966_Thursday = Date(timeIntervalSince1970: -99792000)
    static let december_8_2021_Wednesday = Date(timeIntervalSince1970: 1638921600)
    
    static let january_1_2024_Monday = Date(timeIntervalSince1970: 1704067200)
    static let january_10_2024_Wednesday = Date(timeIntervalSince1970: 1704844800)
    
    init(
        year: Int, month: Int, day: Int,
        calendar: Calendar = .init(identifier: .gregorian),
        file: StaticString = #file, line: UInt = #line
    ) throws {
        self = try XCTUnwrap(
            calendar.date(from: .init(year: year, month: month, day: day)),
            file: file, line: line
        )
    }
}

