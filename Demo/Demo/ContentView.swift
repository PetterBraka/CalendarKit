//
//  ContentView.swift
//  Demo
//
//  Created by Petter vang Brakalsvålet on 31/12/2023.
//

import SwiftUI
import CalendarKit

let calendar = Calendar.current

enum PathOption: String, Identifiable {
    var id: String { rawValue }
    
    case `default`
    case custom
}

struct ContentView: View {
    @State var start = calendar.date(from: .init(year: 2022, month: 1))!
    @State var end = calendar.date(from: .init(year: 2024, month: 12))!
    @State var selectedDate = Date.now
    
    @State var enabledJumpTo = false
    @State var startOfWeek = "monday"
    @State var orientation: Orientation = .horizontal
    
    @State var path: PathOption?
    
    var body: some View {
        NavigationStack {
            List {
                Section("Customisations") {
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
                            .tag(weekday)
                        }
                    } label: {
                        Text("Start of the week")
                    }
                    Picker(selection: $orientation) {
                        Button("Vertical") {
                            orientation = .vertical
                        }
                        Button("Horizontal") {
                            orientation = .horizontal
                        }
                    } label: {
                        Text("Calendar orientation")
                    }

                }
                Section("Demo Views") {
                    NavigationLink("Show Default Calendar", value: PathOption.default)
                    NavigationLink("Show Custom Calendar", value: PathOption.custom)
                }
            }
            .navigationTitle("Calendar demo")
            .navigationDestination(for: PathOption.self) { path in
                switch path {
                case .default:
                    CalendarDemo(start: start, end: end,
                                 selectedDate: $selectedDate,
                                 enabledJumpTo: enabledJumpTo,
                                 startOfWeek: startOfWeek)
                case .custom:
                    CustomCalendarView(start: start, end: end,
                                       selectedDate: $selectedDate,
                                       orientation: orientation,
                                       enabledJumpTo: enabledJumpTo,
                                       startOfWeek: startOfWeek)
                }
            }
        }
        .toolbarTitleDisplayMode(.large)
    }
}

#Preview {
    ContentView()
}
