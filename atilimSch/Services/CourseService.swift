import Foundation

class CourseService {
    let endpointURL = "https://atilimbackend-nu4gg.ondigitalocean.app/generateSchedule"
    
    func fetchCourseDetails(courseIds: [String], completion: @escaping (Welcome?, Error?) -> Void) {
        guard let url = URL(string: endpointURL) else {
            completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: [String]] = ["courseIds": courseIds]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                        do {
                            let scheduleOptions = try JSONDecoder().decode(Welcome.self, from: data)
                            completion(scheduleOptions, nil)
                        } catch {
                            print("Decoding error: \(error)")
                            completion(nil, error)
                        }
                    } else {
                        print("No data received or data could not be converted to String.")
                        completion(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received or data conversion error"]))
                    }
        }.resume()
    }
}
