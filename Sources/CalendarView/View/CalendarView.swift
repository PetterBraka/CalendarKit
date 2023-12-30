import SwiftUI

public struct CalendarView<DayView: View,
                           DayBackground: View,
                           WeekdayLabelsBackground: View>: View {
    typealias CalendarDate = ViewModel.CalendarDate
    
    @ObservedObject private var observer: Observer
    private let presenter: Presenter
    private var viewModel: ViewModel { presenter.viewModel }
    
    // Custom Views
    private let customDayView: ((CalendarDate) -> DayView)?
    private let customDayBackground: ((CalendarDate) -> DayBackground)?
    private let customWeekdayLabelsBackground: (() -> WeekdayLabelsBackground)?
    
    // Actions
    private let onTap: (CalendarDate) -> Void
    
    init(month: Int,
         year: Int,
         startOfWeek: Weekday,
         customDayView: ((CalendarDate) -> DayView)?,
         customDayBackground: ((CalendarDate) -> DayBackground)?,
         customWeekdayLabelsBackground: (() -> WeekdayLabelsBackground)?,
         onTap: @escaping (CalendarDate) -> Void) {
        self.presenter = Presenter(month: month, year: year, startOfWeek: startOfWeek)
        self.observer = Observer(presenter: presenter)
        self.customDayView = customDayView
        self.customDayBackground = customDayBackground
        self.customWeekdayLabelsBackground = customWeekdayLabelsBackground
        self.onTap = onTap
        
        presenter.scene = observer
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 8) {
            titleStack
            monthView
                .id(viewModel.title)
                .animation(.linear, value: viewModel.title)
                .transition(.opacity)
        }
            .dragGesture(directions: [.left, .right]) { swipe in
                print(swipe)
            } onEnd: { swipe in
                switch swipe {
                case .left:
                    observer.perform(action: .didLast)
                case .right:
                    observer.perform(action: .didNext)
                case .down, .up:
                    break
                }
            }
    }
    
    @ViewBuilder
    var titleStack: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                observer.perform(action: .didLast)
            } label: {
                Image.arrowLeft
            }
            Spacer()
            Text(viewModel.title)
                .onTapGesture {
                    observer.perform(action: .didTapToday)
                }
            Spacer()
            Button {
                observer.perform(action: .didNext)
            } label: {
                Image.arrowRight
            }
        }
        .font(.title3)
    }
}

// MARK: - Month
extension CalendarView {
    public var monthView: some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            weekdayLabels
                .font(.body)
            monthCells
                .font(.caption)
        }
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    var weekdayLabels: some View {
        GridRow {
            ForEach(viewModel.weekdays, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background {
            if let customWeekdayLabelsBackground {
                customWeekdayLabelsBackground()
            } else {
                Color.accentColor.opacity(0.75)
            }
        }
    }
    
    @ViewBuilder
    var monthCells: some View {
        ForEach(viewModel.dates.chunked(into: 7), id: \.self) { week in
            GridRow {
                ForEach(week, id: \.date) { date in
                    if let customDayView {
                        customDayView(date)
                    } else {
                        dayView(date: date)
                    }
                }
            }
        }
    }
}

// MARK: - Day
extension CalendarView {
    @ViewBuilder
    func dayView(date: CalendarDate) -> some View {
        let day = Calendar.current.component(.day, from: date.date)
        Text("\(day)")
            .opacity(date.isThisMonth ? 1.0 : 0.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                if let customDayBackground {
                    customDayBackground(date)
                } else {
                    dayBackground(date: date)
                }
            }
            .onTapGesture {
                onTap(date)
            }
    }
    
    @ViewBuilder
    func dayBackground(date: CalendarDate) -> some View {
        ZStack {
            if !date.isWeekday {
                Color.accentColor
                    .opacity(0.25)
            } else {
                Color.white
            }
            
            Rectangle()
                .fill(.clear)
                .border(.black, width: 0.25)
            
            if date.isToday {
                Circle()
                    .fill(.red)
                    .opacity(0.25)
                    .padding(4)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CalendarView(month: 12, year: 2023, startOfWeek: .monday) { date in
                print(date)
            }
            Spacer()
                .layoutPriority(0)
        }
    }
}
