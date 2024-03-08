//
//  ExamsModel.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 8.03.2024.
//

import Foundation

struct ExamsModel: Codable, Identifiable {
    let courseCode, date, time: String
    
    var id: String { courseCode }
}
