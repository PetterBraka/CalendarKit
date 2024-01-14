//
//  ContentView.swift
//  Demo
//
//  Created by Petter vang Brakalsvålet on 31/12/2023.
//

import SwiftUI
import CalendarKit

let calendar = Calendar.current

struct ContentView: View {
    @State var start = calendar.date(from: .init(year: 2022, month: 1))!
    @State var end = calendar.date(from: .init(year: 2024, month: 12))!
    @State var selectedDate = Date.now
    
    @State var enabledJumpTo = false
    @State var startOfWeek = "monday"
    
    var body: some View {
        NavigationStack {
            List {
                DatePicker(
                    "Start date",
                    selection: $start,
                    displayedComponents: .date
                )
                DatePicker(
                    "End date",
                    selection: $end,
                    displayedComponents: .date
                )
                if enabledJumpTo {
                    DatePicker(
                        "Selected date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                }
                Toggle("Enable jump to date", isOn: $enabledJumpTo)
                let weekdays = ["monday", "tuesday", "wednesday", "thursday",
                                "friday", "saturday", "sunday"]
                Picker(selection: $startOfWeek) {
                    ForEach(weekdays, id: (\.self)) { weekday in
                        Button(weekday.capitalized) {
                            startOfWeek = weekday
                        }
                    }
                } label: {
                    Text("Start of the week")
                }
                NavigationLink("Open Calendar", value: "Open")
            }
            .navigationTitle("Calendar demo")
            .navigationDestination(for: String.self) { _ in
                CalendarDemo(start: start, end: end,
                             selectedDate: $selectedDate,
                             enabledJumpTo: enabledJumpTo,
                             startOfWeek: startOfWeek)
            }
        }
        .toolbarTitleDisplayMode(.large)
    }
}

#Preview {
    ContentView()
}
