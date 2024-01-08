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
    @State var date = Date.now
    
    var body: some View {
        VStack {
            Text("Calendar demo")
            
            CalendarView(selectedDate: $date,
                         range: start ... end,
                         startOfWeek: .monday) { date in
                print(date)
            }
            
            VStack {
                Button("Set date - 2023 Jan 1") {
                    date = Calendar.current.date(from: .init(year: 2023, month: 1))!
                }
                Button("Set date - 2023 Dec 1") {
                    date = Calendar.current.date(from: .init(year: 2023, month: 12))!
                }
                Button("Set date - 2023 June 1") {
                    date = Calendar.current.date(from: .init(year: 2023, month: 6))!
                }
            }
            .padding(.all)
            
            CalendarView(range: start ... end,
                         startOfWeek: .monday,
                         orientation: .horizontal) {  date in
                print(date)
            }

            Spacer()
                .layoutPriority(0)
        }
    }
}

#Preview {
    ContentView()
}
