//
//  PageViewModel.swift
//
//
//  Created by Petter vang Brakalsvålet on 05/01/2024.
//

import Foundation

public struct PageViewModel {
    let pageIndex: Int
    let month: Int
    let year: Int
    let title: String
    let weekdays: [String]
    let dates: [CalendarDate]
}
