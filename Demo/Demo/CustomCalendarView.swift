//
//  CustomCalendarView.swift
//  Demo
//
//  Created by Petter vang Brakalsvålet on 14/01/2024.
//

import SwiftUI
import CalendarKit
import Presenter

struct CustomCalendarView: View {
    var start: Date
    var end: Date
    @Binding var selectedDate: Date
    var orientation: Orientation
    var enabledJumpTo: Bool
    var startOfWeek: String
    var weekday: Weekday {
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
            CalendarView(
                range: start ... end,
                startOfWeek: weekday,
                orientation: orientation){ day in
                    Text("\(day.day)")
                        .font(.body)
                        .padding(8)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(day.isToday ? .white : day.isWeekday ? .blue : .black)
                        .background {
                            ZStack {
                                Rectangle()
                                    .fill(day.isWeekday ? .clear : .blue)
                                    .opacity(0.2)
                                if day.isToday {
                                    Circle()
                                        .fill(.red)
                                        .opacity(0.75)
                                        .padding(2)
                                }
                            }
                        }
                        .opacity(day.isThisMonth ? 1 : 0.5)
                } customWeekdayLabel: { weekday in
                    Text(weekday)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                        .foregroundStyle(.blue)
                        .background {
                            Color.blue
                                .opacity(0.2)
                        }
                } customMonthLabel: { month in
                    Text(month)
                        .font(.title.bold())
                        .frame(maxWidth: .infinity)
                        .padding(6)
                        .foregroundStyle(.white)
                        .background {
                            Color.blue
                                .opacity(0.75)
                        }
                } onTap: { day in
                    print(day)
                }
            Spacer()
                .layoutPriority(0)
        }
    }
}

#Preview {
    CustomCalendarView(
        start: Calendar.current.date(byAdding: .init(month: -10), to: .now)!,
        end: Calendar.current.date(byAdding: .init(month: 10), to: .now)!,
        selectedDate: .constant(.now),
        orientation: .horizontal,
        enabledJumpTo: true,
        startOfWeek: "monday"
    )
}
