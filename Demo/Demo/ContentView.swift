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
    let start = calendar.date(from: .init(year: 2022, month: 1))!
    let end = calendar.date(from: .init(year: 2024, month: 12))!
    
    @State var index = 0
    var body: some View {
        VStack {
            Text("Calendar demo")
            
            CalendarView(range: start ... end, startOfWeek: .monday) { date in
                print(date)
            }
            CalendarView(range: start ... end, startOfWeek: .monday) {  date in
                print(date)
            } customDayView: { date in
                VStack(alignment: .center, spacing: 0) {
                    Text("\(Calendar.current.component(.day, from: date.date))")
                        .opacity(date.isThisMonth ? 1.0 : 0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .opacity(date.isWeekday ? 0 : 0.25)
                        }
                    Spacer()
                }
            } customWeekdayLabel: { text in
                Text(text)
            }

            Spacer()
                .layoutPriority(0)
        }
    }
}

#Preview {
    ContentView()
}
