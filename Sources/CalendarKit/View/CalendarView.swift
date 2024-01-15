import SwiftUI
import Presenter
import PageView

public struct CalendarView<DayView: View,
                           DayBackground: View,
                           WeekdayLabel: View,
                           MonthLabel: View>: View {
    public typealias CalendarDate = ViewModel.CalendarDate
    @ObservedObject private var observer: Observer
    @Binding var selectedDate: Date?
    
    let orientation: Orientation
    
    let cornerRadius: CGFloat = 12
    
    // Custom Views
    private let customDayView: ((CalendarDate) -> DayView)?
    private let customDayBackground: ((CalendarDate) -> DayBackground)?
    private let customWeekdayLabel: ((String) -> WeekdayLabel)?
    private let customMonthLabel: ((String) -> MonthLabel)?
    
    // Actions
    private let onTap: (CalendarDate) -> Void
    
    init(startDate: Date = .now,
         range: ClosedRange<Date>,
         startOfWeek: ViewModel.Weekday,
         orientation: Orientation,
         customDayView: ((CalendarDate) -> DayView)?,
         customDayBackground: ((CalendarDate) -> DayBackground)?,
         customWeekdayLabel: ((String) -> WeekdayLabel)?,
         customMonthLabel: ((String) -> MonthLabel)?,
         onTap: @escaping (CalendarDate) -> Void) {
        let presenter = Presenter(
            startDate: startDate,
            range: range,
            startOfWeek: startOfWeek
        )
        self.observer = Observer(presenter: presenter)
        self.orientation = orientation
        self.customDayView = customDayView
        self.customDayBackground = customDayBackground
        self.customWeekdayLabel = customWeekdayLabel
        self.customMonthLabel = customMonthLabel
        self.onTap = onTap
        _selectedDate = .constant(nil)
        
        presenter.scene = observer
    }
    
    init(selectedDate: Binding<Date>,
         range: ClosedRange<Date>,
         startOfWeek: ViewModel.Weekday,
         customDayView: ((CalendarDate) -> DayView)?,
         customDayBackground: ((CalendarDate) -> DayBackground)?,
         customWeekdayLabel: ((String) -> WeekdayLabel)?,
         customMonthLabel: ((String) -> MonthLabel)?,
         onTap: @escaping (CalendarDate) -> Void) {
        let presenter = Presenter(
            startDate: selectedDate.wrappedValue,
            range: range,
            startOfWeek: startOfWeek
        )
        self.observer = Observer(presenter: presenter)
        self.orientation = .horizontal
        self.customDayView = customDayView
        self.customDayBackground = customDayBackground
        self.customWeekdayLabel = customWeekdayLabel
        self.customMonthLabel = customMonthLabel
        self.onTap = onTap
        _selectedDate = Binding {
            selectedDate.wrappedValue
        } set: { date in
            if let date {
                selectedDate.wrappedValue = date
            }
        }
        
        presenter.scene = observer
    }
    
    public var body: some View {
        content
            .contentShape(Rectangle())
            .accessibilityLabel(
                observer.viewModel.selectedDate.formatted(date: .long,
                                                          time: .omitted)
            )
    }
    
    @ViewBuilder
    private var content: some View {
        if selectedDate != nil {
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
            .accessibilityAction(named: "Next month") {
                if observer.pages.count < observer.viewModel.currentPage {
                    selectionBinding.wrappedValue += 1
                } else {
                    UIAccessibility.post(
                        notification: .announcement,
                        argument: "On last month"
                    )
                }
            }
            .accessibilityAction(named: "Previous month") {
                if observer.viewModel.currentPage > 0 {
                    selectionBinding.wrappedValue -= 1
                } else {
                    UIAccessibility.post(
                        notification: .announcement,
                        argument: "On first month"
                    )
                }
            }
            .animation(.default, value: observer.viewModel.currentPage)
            .onChange(of: observer.viewModel.selectedDate) { _, newDate in
                selectedDate = newDate
            }
        } else {
            PageView(
                initialIndex: observer.viewModel.currentPage,
                pages: observer.pages.map { page($0) },
                orientation: .init(from: orientation)
            )
        }
    }
    
    @ViewBuilder
    private func page(_ viewModel: ViewModel.Page) -> some View {
        VStack(spacing: 0) {
            titleStack(viewModel)
                .accessibilityHeading(.h1)
            monthView(viewModel)
        }
    }
    
    @ViewBuilder
    private func titleStack(_ viewModel: ViewModel.Page) -> some View {
        if let customMonthLabel {
            customMonthLabel(viewModel.title)
        } else {
            Text(viewModel.title)
                .onTapGesture {
                    observer.perform(action: .didSetPageTo(date: .now))
                }
                .font(.title)
                .bold()
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background {
                    Color.accentColor
                        .contrast(0.75)
                }
                .clipShape(.rect(topLeadingRadius: cornerRadius,
                                 topTrailingRadius: cornerRadius))
        }
    }
}

// MARK: - Month
private extension CalendarView {
    func monthView(_ viewModel: ViewModel.Page) -> some View {
        Grid(alignment: .center, horizontalSpacing: 0, verticalSpacing: 0) {
            weekdayLabels(viewModel)
                .accessibilityHeading(.h2)
                .dynamicTypeSize(.xSmall ... .xxxLarge)
            monthCells(viewModel)
        }
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    func weekdayLabels(_ viewModel: ViewModel.Page) -> some View {
        GridRow {
            ForEach(viewModel.weekdays, id: \.long.self) { (short, long) in
                Group {
                    if let customWeekdayLabel {
                        customWeekdayLabel(short)
                    } else {
                        Text(short)
                            .font(.headline.bold())
                            .foregroundStyle(Color.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background {
                                Color.accentColor.opacity(0.2)
                            }
                            .background {
                                Rectangle()
                                    .fill(.clear)
                                    .border(.black, width: 0.25)
                            }
                    }
                }
                .accessibilityLabel(long)
            }
        }
    }
    
    @ViewBuilder
    func monthCells(_ viewModel: ViewModel.Page) -> some View {
        ForEach(viewModel.dates.chunked(into: 7), id: \.self) { week in
            GridRow {
                ForEach(week, id: \.date) { day in
                    Group {
                        if let customDayView {
                            customDayView(day)
                        } else {
                            dayView(date: day)
                        }
                    }
                    .accessibilityLabel(
                        day.date.formatted(
                            Date.FormatStyle()
                                .year(.twoDigits)
                                .month(.twoDigits)
                                .day(.twoDigits)
                                .weekday(.wide)
                                .locale(.current)
                        )
                    )
                    .accessibilityAddTraits(.isButton)
                    .accessibilityRemoveTraits(.isStaticText)
                    .accessibilityAction {
                        onTap(day)
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
        Text("\(date.day)")
            .font(date.isWeekday ? .body : .body.bold())
            .foregroundStyle(date.isToday ? .white : 
                                date.isWeekday ? .black : .accentColor.opacity(0.75))
            .padding(12)
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            .background {
                if let customDayBackground {
                    customDayBackground(date)
                } else {
                    dayBackground(date: date)
                }
            }
            .contentShape(Rectangle())
            .opacity(date.isThisMonth ? 1 : 0.25)
            .onTapGesture {
                onTap(date)
            }
    }
    
    @ViewBuilder
    func dayBackground(date: CalendarDate) -> some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .border(.black, width: 0.25)
                .opacity(0.5)
            
            if date.isToday {
                Circle()
                    .fill(Color.accentColor)
                    .opacity(0.75)
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
            CalendarView(range: start ... end, startOfWeek: .monday, orientation: .horizontal) { date in
                print(date)
            }
            .accentColor(.red)
            Spacer()
                .layoutPriority(0)
        }
    }
}
