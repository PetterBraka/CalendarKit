//
//  ContentView.swift
//  Demo
//
//  Created by Petter vang Brakalsvålet on 31/12/2023.
//

import SwiftUI
import CalendarView

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
            Spacer()
                .layoutPriority(0)
        }
    }
}

#Preview {
    ContentView()
}
