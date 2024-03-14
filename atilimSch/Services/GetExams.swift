import Foundation

class GetExams {
    
    func fetchExams(from urlString: String, completion: @escaping ([ExamsModel]) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let exams = try JSONDecoder().decode([ExamsModel].self, from: data)
                DispatchQueue.main.async {
                    completion(exams)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Received data: \(dataString)")
                }
            }
        }.resume()
    }
}
