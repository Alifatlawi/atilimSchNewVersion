//
//  CoursesModel.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 21.01.2024.
//

import Foundation

struct Course: Codable, Identifiable {
    let id: String
    let name: String
    let sections: [Sections]
}

struct Sections: Codable, Identifiable {
    let id: String
    let teacher: Teacher
    let schedules: [Schedule]
}

struct Teacher: Codable {
    let name: String
}

struct Schedule: Codable {
    let day: String
    let classroom: String
    let period: String
    let startTime: String
    let endTime: String
    let duration: String
}
