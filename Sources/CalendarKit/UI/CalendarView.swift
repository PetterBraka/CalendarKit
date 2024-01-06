import SwiftUI

public struct CalendarView<DayView: View,
                           DayBackground: View,
                           WeekdayLabel: View>: View {
    @ObservedObject private var observer: Observer
    
    // Custom Views
    private let customDayView: ((CalendarDate) -> DayView)?
    private let customDayBackground: ((CalendarDate) -> DayBackground)?
    private let customWeekdayLabel: ((String) -> WeekdayLabel)?
    
    // Actions
    private let onTap: (CalendarDate) -> Void
    
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: Weekday,
         customDayView: ((CalendarDate) -> DayView)?,
         customDayBackground: ((CalendarDate) -> DayBackground)?,
         customWeekdayLabel: ((String) -> WeekdayLabel)?,
         onTap: @escaping (CalendarDate) -> Void) {
        let presenter = Presenter(startDate: startDate, range: range, startOfWeek: startOfWeek)
        self.observer = Observer(presenter: presenter)
        self.customDayView = customDayView
        self.customDayBackground = customDayBackground
        self.customWeekdayLabel = customWeekdayLabel
        self.onTap = onTap
        
        presenter.scene = observer
    }
    
    public var body: some View {
//        PageView(
//            initialIndex: observer.viewModel.currentPage,
//            pages: observer.pages.map { page($0) },
//            orientation: .horizontal
//        )
        
        let selectionBinding = Binding {
            observer.viewModel.currentPage
        } set: { page in
            observer.perform(action: .didSet(page: page))
        }
        TabView(selection: selectionBinding) {
            ForEach(observer.pages, id: \.pageIndex) { model in
                page(model)
                    .tag(model.pageIndex)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.default, value: observer.viewModel.currentPage)
    }
    
    @ViewBuilder
    private func page(_ viewModel: PageViewModel) -> some View {
        VStack(spacing: 0) {
            titleStack(viewModel)
            monthView(viewModel)
        }
    }
    
    @ViewBuilder
    private func titleStack(_ viewModel: PageViewModel) -> some View {
        Text(viewModel.title)
            .onTapGesture {
                observer.perform(action: .didSetPageTo(date: .now))
            }
        .font(.title3)
    }
}

// MARK: - Month
private extension CalendarView {
    func monthView(_ viewModel: PageViewModel) -> some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            weekdayLabels(viewModel)
                .font(.body)
            monthCells(viewModel)
                .font(.caption)
        }
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    func weekdayLabels(_ viewModel: PageViewModel) -> some View {
        GridRow {
            ForEach(viewModel.weekdays, id: \.self) { day in
                if let customWeekdayLabel {
                    customWeekdayLabel(day)
                } else {
                    Text(day)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            Color.accentColor.opacity(0.75)
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    func monthCells(_ viewModel: PageViewModel) -> some View {
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
