import SwiftUI
import CoreData

struct ScheduleResultView: View {
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    let fullDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let startHour = 9
    let endHour = 18

    @FetchRequest(
        entity: CourseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CourseEntity.name, ascending: true)]
    ) var courses: FetchedResults<CourseEntity>
    
    

    var body: some View {
        ScrollView([.vertical, .horizontal]) {
            VStack {
                scheduleHeader
                scheduleGrid
            }
        }
        .padding()
    }

    private var scheduleHeader: some View {
        HStack {
            Text("Time")
                .frame(width: 50, alignment: .leading)
            ForEach(days, id: \.self) { day in
                Text(day)
                    .frame(minWidth: 100, alignment: .center)
            }
        }
        .font(.headline)
    }

    private var scheduleGrid: some View {
        VStack(spacing: 0) {
            ForEach(startHour..<endHour, id: \.self) { hour in
                HStack {
                    Text("\(hour):30")
                        .frame(width: 50, alignment: .leading)
                    ForEach(days, id: \.self) { day in
                        scheduleCell(for: day, hour: hour)
                            .frame(minWidth: 100, minHeight: 60)
                    }
                }
            }
        }
    }

    private func scheduleCell(for day: String, hour: Int) -> some View {
        let scheduleInfo = schedule(for: day, hour: hour)
        return Rectangle()
            .fill(scheduleInfo != nil ? Color(hex: scheduleInfo?.course.color ?? "#D3D3D3") : Color.clear)
            .border(Color.gray.opacity(0.3), width: 0.5)
            .overlay(
                VStack {
                    if let course = scheduleInfo?.course, let schedule = scheduleInfo?.schedule {
                        Text(course.id ?? "N/A")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("\(schedule.classroom ?? "TBD")")
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding(4)
            )
    }


    private func schedule(for day: String, hour: Int) -> (course: CourseEntity, schedule: ScheduleEntity)? {
        guard let dayIndex = days.firstIndex(of: day), dayIndex < fullDays.count else { return nil }
        let fullDayName = fullDays[dayIndex]

        for course in courses {
            guard let sections = course.sections?.allObjects as? [SectionEntity] else { continue }
            for section in sections {
                guard let schedules = section.schedules?.allObjects as? [ScheduleEntity] else { continue }
                for schedule in schedules {
                    if schedule.day == fullDayName && isTimeWithinSchedule(hour: hour, schedule: schedule) {
                        return (course, schedule)
                    }
                }
            }
        }
        print("No schedule found for \(fullDayName) at \(hour):00")
        return nil
    }

    private func isTimeWithinSchedule(hour: Int, schedule: ScheduleEntity) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        guard let startTime = formatter.date(from: schedule.startTime ?? ""),
              let endTime = formatter.date(from: schedule.endTime ?? "") else {
            return false
        }

        let calendar = Calendar.current
        let startHour = calendar.component(.hour, from: startTime)
        let endHour = calendar.component(.hour, from: endTime)
        let startMinute = calendar.component(.minute, from: startTime)
        let endMinute = calendar.component(.minute, from: endTime)

        if hour < startHour || hour > endHour {
            return false
        }

        if hour == startHour && startMinute > 0 {
            return false
        }

        if hour == endHour && hour != startHour && endMinute == 0 {
            return false
        }

        return true
    }


}

#Preview {
    ScheduleResultView()
}




extension Color {
    var hex: String? {
        guard let components = self.cgColor?.components, components.count >= 3 else {
            return "#0000FF" // Default to blue if cgColor is nil or not enough components
        }
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
