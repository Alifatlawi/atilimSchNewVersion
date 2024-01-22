//
//  DynamicScheduleView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI
import CoreData

struct DynamicScheduleView: View {
    let scheduleOptions: Welcome  // Using the Welcome typealias
    @State private var selectedOptionIndex = 0
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri"]
    let fullDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    let startHour = 9
    let endHour = 18
    
    var body: some View {
           NavigationView {
               VStack {
                   if scheduleOptions.isEmpty {
                       Text("No schedule found for these courses 😔")
                           .font(.headline)
                           .padding()
                   } else {
                       ScrollView([.vertical, .horizontal]) {
                           VStack {
                               scheduleHeader
                               if scheduleOptions.indices.contains(selectedOptionIndex) {
                                   scheduleGrid(for: scheduleOptions[selectedOptionIndex])
                               }
                           }
                       }
                       .padding()
                   }

                   navigationButtons
               }
               .navigationBarTitle("Schedule", displayMode: .inline)
               .navigationBarItems(trailing: Button("Save") {
                   saveCurrentSchedule()
               })
               .navigationBarBackButtonHidden(true) // Hides the back button
           }
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
        var courseDetails: (courseID: String, sectionID: String)? = nil

        for course in courseGroups {
            for schedule in course.section.schedules {
                if isTimeWithinSchedule(day: day, hour: hour, schedule: schedule) {
                    courseDetails = (course.courseID, course.section.id)  // Updated to use section ID
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
                        Text("Sec: \(details.sectionID)")  // Displaying the section ID
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.7))
                    }
                }
                .padding(4)
            )
    }

    
    private func isTimeWithinSchedule(day: String, hour: Int, schedule: deSchedule) -> Bool {
        let scheduleDayInEnglish = convertDayToEnglish(schedule.day)
        
        // Ensure day names match (e.g., "Monday" with "Monday")
        guard day == scheduleDayInEnglish else {
            return false
        }
        
        // Convert start and end times to hours and compare
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm" // Assuming time is in "Hour:Minute" format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let startTime = formatter.date(from: schedule.startTime),
              let endTime = formatter.date(from: schedule.endTime) else {
            return false
        }
        
        let calendar = Calendar.current
        let startHour = calendar.component(.hour, from: startTime)
        let endHour = calendar.component(.hour, from: endTime)
        
        return hour >= startHour && hour < endHour
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
    
    private func convertDayToEnglish(_ day: String) -> String {
        switch day {
        case "Pazartesi": return "Monday"
        case "Salı": return "Tuesday"
        case "Çarşamba": return "Wednesday"
        case "Perşembe": return "Thursday"
        case "Cuma": return "Friday"
        case "Cumartesi": return "Saturday"
        case "Pazar": return "Sunday"
        default: return day
        }
    }
    
    private func saveCurrentSchedule() {
        guard scheduleOptions.indices.contains(selectedOptionIndex) else { return }
        
        let selectedCourses = scheduleOptions[selectedOptionIndex]
        for course in selectedCourses {
            let newCourse = CourseEntity(context: moc)
            newCourse.id = course.courseID
            newCourse.name = course.courseName
            // newCourse.color = "<Your Default Color>" // Add color if necessary
            
            let newSection = SectionEntity(context: moc)
            newSection.id = course.section.id
            newCourse.addToSections(newSection)
            
            let newTeacher = TeacherEntity(context: moc)
            newTeacher.name = course.section.teacher.name
            newSection.teacher = newTeacher
            
            for schedule in course.section.schedules {
                let newSchedule = ScheduleEntity(context: moc)
                newSchedule.day = convertDayToEnglish(schedule.day)
                newSchedule.classroom = schedule.classroom
                newSchedule.period = schedule.period
                newSchedule.startTime = schedule.startTime
                newSchedule.endTime = schedule.endTime
                newSchedule.duration = schedule.duration
                newSection.addToSchedules(newSchedule)
            }
        }
        
        do {
            try moc.save()
            dismiss()
        } catch {
            // Handle error, e.g., show an error message
            print("Error saving schedule: \(error)")
        }
    }
    
}

//
//#Preview {
//    DynamicScheduleView()
//}
