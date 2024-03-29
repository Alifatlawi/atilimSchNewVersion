//
//  GetData.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 21.01.2024.
//

import Foundation

class DataService {
    func fetchCourses(completion: @escaping ([Course]?) -> Void) {
        guard let url = URL(string: "https://atilim-759xz.ondigitalocean.app/courses") else {
            print("invalid url")
            completion(nil)
            return
        }
                
        URLSession.shared.dataTask(with: url) { data , reponse , error in
                
            guard let data = data, error == nil else {
                print("Error fetching data")
                completion(nil)
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    completion(courses)
                }
            } catch {
                print("Error decoding json: \(error)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received data: \(dataString)")
                }
                completion(nil)
            }
        }.resume()
    }
}
