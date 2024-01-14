//
//  CalendarDemo.swift
//  Demo
//
//  Created by Petter vang Brakalsvålet on 14/01/2024.
//

import SwiftUI
import CalendarKit
import Presenter

struct CalendarDemo: View {
    var start: Date
    var end: Date
    @Binding var selectedDate: Date
    var enabledJumpTo: Bool
    var startOfWeek: String
    var weekday: ViewModel.Weekday {
        switch startOfWeek {
        case "monday":
            return .monday
        case "tuesday":
            return .tuesday
        case"wednesday":
            return .wednesday
        case"thursday":
            return .thursday
        case"friday":
            return .friday
        case"saturday":
            return .saturday
        default:
            return .sunday
        }
    }
    
    var body: some View {
        VStack {
            calendar
            Spacer()
        }
    }
    
    @ViewBuilder
    var calendar: some View {
        if enabledJumpTo {
            CalendarView(
                selectedDate: $selectedDate,
                range: start ... end,
                startOfWeek: weekday) { date in
                    print(date)
                }
        } else {
            CalendarView(
                range: start ... end,
                startOfWeek: weekday,
                orientation: .horizontal) {  date in
                    print(date)
                }
        }
    }
}
