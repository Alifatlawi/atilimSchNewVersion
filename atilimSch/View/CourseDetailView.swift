//
//  CourseDetailView.swift
//  AtilimSchedule
//
//  Created by Tacettin Pekin on 5.10.2023.
//

// CourseDetailView.swift
import SwiftUI
import CoreData

struct CourseDetailView: View {
    var course: Course
    @Environment(\.managedObjectContext) var moc
    @State private var showingConflictAlert = false
    @State private var selectedColor: Color = Color.blue
    @State private var conflictDay = ""
    @State private var saveSuccessful = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section(header: Text("Course Information")) {
                Text("ID: \(course.id)")
                Text("Name: \(course.name)")
            }
            
            ForEach(course.sections, id: \.id) { section in
                SwiftUI.Section(header: Text("Section \(section.id)")) {  // specify SwiftUI.Section
                    Text("Teacher: \(section.teacher.name)")
                    
                    ForEach(section.schedules, id: \.day) { schedule in
                        VStack(alignment: .leading) {
                            Text("Day: \(convertDayToEnglish(schedule.day))")  // Convert day to English
                            Text("Classroom: \(schedule.classroom)")
                            Text("Start Time: \(schedule.startTime)")
                            Text("End Time: \(schedule.endTime)")
                        }
                    }
                    ColorPicker("Select Color", selection: $selectedColor)
                    
                    Button {
                        addCourse(for: section)
                    } label: {
                        Text("Add this to your Courses")
                    }
                }
            }

            
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(course.id)
        .alert(isPresented: $saveSuccessful) {  // Alert is shown when saveSuccessful is true
                    Alert(
                        title: Text("Course Added"),
                        message: Text("The course has been added to your schedule successfully."),
                        dismissButton: .default(Text("OK"))
                    )
                }
        
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
    
    private func addCourse(for selectedSection: Sections) {
        let newCourse = CourseEntity(context: moc)
        newCourse.id = course.id
        newCourse.name = course.name
        newCourse.color = selectedColor.toHex() // replace with a color value or remove if not needed
        
        let newSection = SectionEntity(context: moc)
        newSection.id = selectedSection.id
        newSection.course = newCourse
        
        let newTeacher = TeacherEntity(context: moc)
        newTeacher.name = selectedSection.teacher.name
        newSection.teacher = newTeacher
        
        for schedule in selectedSection.schedules {
            let newSchedule = ScheduleEntity(context: moc)
            newSchedule.day = convertDayToEnglish(schedule.day)
            newSchedule.classroom = schedule.classroom
            newSchedule.period = schedule.period
            newSchedule.startTime = schedule.startTime
            newSchedule.endTime = schedule.endTime
            newSchedule.duration = schedule.duration
            newSection.addToSchedules(newSchedule)
        }
        
        newCourse.addToSections(newSection)
        
        do {
            try moc.save()
            saveSuccessful = true
            dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

extension Color {
    func toHex() -> String {
        guard let cgColor = self.cgColor else {
            return "0000FF"  // Default to blue if cgColor is nil
        }
        let components = cgColor.components!.map { $0 * 255 }
        let hexString = String(format: "%02X%02X%02X", Int(components[0]), Int(components[1]), Int(components[2]))
        return hexString
    }
}


//#Preview {
//    CourseDetailView()
//}
