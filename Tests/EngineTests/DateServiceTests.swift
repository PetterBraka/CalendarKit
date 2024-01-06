//
//  DateServiceTests.swift
//  
//
//  Created by Petter vang Brakalsvålet on 06/01/2024.
//

@testable import Engine
import XCTest

final class DateServiceTests: XCTestCase {
    var service: DateServiceType!
    
    override func setUp() {
        service = DateService(calendar: .init(identifier: .gregorian))
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
