//
//  DynamicScheduleView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct DynamicScheduleView: View {
    let scheduleOptions: Welcome  // Using the Welcome typealias
    @State private var selectedOptionIndex = 0
    
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    let fullDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let startHour = 9
    let endHour = 18
    
    var body: some View {
        ScrollView([.vertical, .horizontal]) {
            VStack {
                scheduleHeader
                if scheduleOptions.indices.contains(selectedOptionIndex) {
                    scheduleGrid(for: scheduleOptions[selectedOptionIndex])
                }
            }
        }
        .padding()
        navigationButtons
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
    
    private func scheduleGrid(for courseGroups: [WelcomeElement]) -> some View {
        VStack(spacing: 0) {
            ForEach(startHour..<endHour, id: \.self) { hour in
                HStack {
                    Text("\(hour):30")
                        .frame(width: 50, alignment: .leading)
                    ForEach(days.indices, id: \.self) { index in
                        scheduleCell(for: fullDays[index], hour: hour, courseGroups: courseGroups)
                            .frame(minWidth: 100, minHeight: 60)
                    }
                }
            }
        }
    }
    
    private func scheduleCell(for day: String, hour: Int, courseGroups: [WelcomeElement]) -> some View {
            var courseDetails: (courseID: String, classroom: String)? = nil

            for course in courseGroups {
                for schedule in course.section.schedules {
                    if isTimeWithinSchedule(day: day, hour: hour, schedule: schedule) {
                        courseDetails = (course.courseID, schedule.classroom)
                        break
                    }
                }
                if courseDetails != nil {
                    break
                }
            }

            return Rectangle()
                .fill(courseDetails != nil ? Color.blue : Color.clear)  // Example color
                .border(Color.gray.opacity(0.3), width: 0.5)
                .overlay(
                    VStack {
                        if let details = courseDetails {
                            Text(details.courseID)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text(details.classroom)
                                .font(.footnote)
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .padding(4)
                )
        }
    
    private func isTimeWithinSchedule(day: String, hour: Int, schedule: Schedule) -> Bool {
        guard let scheduleDayIndex = fullDays.firstIndex(of: day),
              let scheduleStartHour = Int(schedule.startTime.prefix(2)),
              let scheduleEndHour = Int(schedule.endTime.prefix(2)) else {
            return false
        }
        
        // Assuming the day names in the schedule are in full format (e.g., "Monday")
        return scheduleDayIndex == days.firstIndex(of: schedule.day) && hour >= scheduleStartHour && hour < scheduleEndHour
    }

    
    private var navigationButtons: some View {
        HStack {
            Button("Previous") {
                if selectedOptionIndex > 0 {
                    selectedOptionIndex -= 1
                }
            }
            .disabled(selectedOptionIndex <= 0)
            
            Spacer()
            
            Text("Schedule \(selectedOptionIndex + 1) of \(scheduleOptions.count)")
                .font(.subheadline)
            
            Spacer()
            
            Button("Next") {
                if selectedOptionIndex < scheduleOptions.count - 1 {
                    selectedOptionIndex += 1
                }
            }
            .disabled(selectedOptionIndex >= scheduleOptions.count - 1)
        }
        .padding()
    }
}

//
//#Preview {
//    DynamicScheduleView()
//}
