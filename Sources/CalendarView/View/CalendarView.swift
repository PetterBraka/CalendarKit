import SwiftUI

public struct CalendarView<DayView: View,
                           DayBackground: View,
                           WeekdayLabelsBackground: View>: View {
    public typealias CalendarDate = ViewModel.CalendarDate
    
    @ObservedObject private var observer: Observer
    private let presenter: Presenter
    private var viewModels: [ViewModel] { presenter.viewModels }
    
    // Custom Views
    private let customDayView: ((CalendarDate) -> DayView)?
    private let customDayBackground: ((CalendarDate) -> DayBackground)?
    private let customWeekdayLabelsBackground: (() -> WeekdayLabelsBackground)?
    
    // Actions
    private let onTap: (CalendarDate) -> Void
    
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         customDayView: ((CalendarDate) -> DayView)?,
         customDayBackground: ((CalendarDate) -> DayBackground)?,
         customWeekdayLabelsBackground: (() -> WeekdayLabelsBackground)?,
         onTap: @escaping (CalendarDate) -> Void) {
        self.presenter = Presenter(startDate: startDate, range: range, startOfWeek: startOfWeek)
        self.observer = Observer(presenter: presenter)
        self.customDayView = customDayView
        self.customDayBackground = customDayBackground
        self.customWeekdayLabelsBackground = customWeekdayLabelsBackground
        self.onTap = onTap
        
        presenter.scene = observer
    }
    
    public var body: some View {
        PageView(
            initialIndex: observer.currentPage,
            pages: viewModels.map { page($0) }
        )
    }
    
    @ViewBuilder
    private func page(_ viewModel: ViewModel) -> some View {
        VStack(spacing: 0) {
            titleStack(viewModel)
            monthView(viewModel)
        }
    }
    
    @ViewBuilder
    private func titleStack(_ viewModel: ViewModel) -> some View {
        Text(viewModel.title)
            .onTapGesture {
                observer.perform(action: .didTapToday)
            }
        .font(.title3)
    }
}

// MARK: - Month
private extension CalendarView {
    func monthView(_ viewModel: ViewModel) -> some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            weekdayLabels(viewModel)
                .font(.body)
            monthCells(viewModel)
                .font(.caption)
        }
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    func weekdayLabels(_ viewModel: ViewModel) -> some View {
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
    func monthCells(_ viewModel: ViewModel) -> some View {
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
private extension CalendarView {
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
            let start = Calendar.current.date(from: .init(year: 2022, month: 1, day: 1))!
            let end = Calendar.current.date(from: .init(year: 2024, month: 12, day: 1))!
            CalendarView(range: start ... end, startOfWeek: .monday) { date in
                print(date)
            }
            Spacer()
                .layoutPriority(0)
        }
    }
}
