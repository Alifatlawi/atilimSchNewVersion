// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let courseID, courseName: String
    let section: deSection

    enum CodingKeys: String, CodingKey {
        case courseID = "courseId"
        case courseName, section
    }
}

// MARK: - Section
struct deSection: Codable {
    let id: String
    let teacher: Teacher
    let schedules: [Schedule]
}

// MARK: - Schedule
struct deSchedule: Codable {
    let day, classroom, period, startTime: String
    let endTime, duration: String
}

// MARK: - Teacher
struct deTeacher: Codable {
    let name: String
}

typealias Welcome = [[WelcomeElement]]
