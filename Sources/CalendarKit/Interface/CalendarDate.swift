//
//  File.swift
//  
//
//  Created by Petter vang Brakalsvålet on 05/01/2024.
//

import Foundation

public struct CalendarDate: Hashable {
    public let date: Date
    public let isToday: Bool
    public let isWeekday: Bool
    public let isThisMonth: Bool
}
