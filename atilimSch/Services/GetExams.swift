//
//  GetExams.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 8.03.2024.
//

import Foundation

class GetExams {
    
    func fetchEngExams(completion: @escaping ([ExamsModel]) -> Void){
        guard let url = URL(string: "https://atilim.alialfatlawi.me/EngMidExams") else {
            print("invalid url")
//            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data , respone, error in
            
            guard let data = data, error == nil else {
                print("Error fetching data")
                return
            }
            
            do {
                let exams = try JSONDecoder().decode([ExamsModel].self, from: data)
                DispatchQueue.main.async {
                    completion(exams)
                }
            } catch {
                print("Error decoding json: \(error)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received data: \(dataString)")
                }
                
            }
        }.resume()
    }
    
    func fetchGenExams(completion: @escaping ([ExamsModel]) -> Void){
        guard let url = URL(string: "https://atilim.alialfatlawi.me/GeneralMidExams") else {
            print("invalid url")
//            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data , respone, error in
            
            guard let data = data, error == nil else {
                print("Error fetching data")
                return
            }
            
            do {
                let exams = try JSONDecoder().decode([ExamsModel].self, from: data)
                DispatchQueue.main.async {
                    completion(exams)
                }
            } catch {
                print("Error decoding json: \(error)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received data: \(dataString)")
                }
                
            }
        }.resume()
    }
    
}
