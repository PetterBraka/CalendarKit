//
//  CalendarDemo.swift
//  Demo
//
//  Created by Petter vang Brakalsvålet on 14/01/2024.
//

import SwiftUI
import CalendarKit

struct CalendarDemo: View {
    var start: Date
    var end: Date
    @Binding var selectedDate: Date
    var enabledJumpTo: Bool
    var startOfWeek: String
    
    var body: some View {
        VStack {
            calendar
            Spacer()
                .layoutPriority(0)
        }
    }
    
    @ViewBuilder
    var calendar: some View {
        if enabledJumpTo {
            CalendarView(
                selectedDate: $selectedDate,
                range: start ... end,
                startOfWeek: {
                    if startOfWeek == "monday" {
                        return .monday
                    }
                    else if startOfWeek == "tuesday" {
                        return .tuesday
                    }
                    else if startOfWeek == "wednesday" {
                        return .wednesday
                    }
                    else if startOfWeek == "thursday" {
                        return .thursday
                    }
                    else if startOfWeek == "friday" {
                        return .friday
                    }
                    else if startOfWeek == "saturday" {
                        return .saturday
                    }
                    else {
                        return .sunday
                    }
                }()) { date in
                    print(date)
                }
        } else {
            CalendarView(
                range: start ... end,
                startOfWeek: {
                    if startOfWeek == "monday" {
                        return .monday
                    }
                    else if startOfWeek == "tuesday" {
                        return .tuesday
                    }
                    else if startOfWeek == "wednesday" {
                        return .wednesday
                    }
                    else if startOfWeek == "thursday" {
                        return .thursday
                    }
                    else if startOfWeek == "friday" {
                        return .friday
                    }
                    else if startOfWeek == "saturday" {
                        return .saturday
                    }
                    else {
                        return .sunday
                    }
                }(),
                orientation: .horizontal) {  date in
                    print(date)
                }
        }
    }
}
