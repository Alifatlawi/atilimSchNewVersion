
import SwiftUI

struct ExamListView: View {
    var body: some View {
        List {
            Section(header: Text("Exams")) {
                NavigationLink("Engineering Exams", destination: ExamsView(urlString: "https://atilim-759xz.ondigitalocean.app/EngMidExams", navigationTitle: "Engineering"))
                NavigationLink("General Exams", destination: ExamsView(urlString: "https://atilim-759xz.ondigitalocean.app/GeneralMidExams", navigationTitle: "General"))
                NavigationLink("Business", destination: ExamsView(urlString: "https://atilim-759xz.ondigitalocean.app/bussMidExams", navigationTitle: "Business"))
                NavigationLink("Civil Aviation", destination: ExamsView(urlString: "https://atilim-759xz.ondigitalocean.app/AviMidExams", navigationTitle: "Civil Aviation"))
                NavigationLink("Arts and sciences", destination: ExamsView(urlString: "https://atilim-759xz.ondigitalocean.app/artsAndSinMidExams", navigationTitle: "Arts and sciences"))
                NavigationLink("Fine Arts and Elective Courses", destination: ExamsView(urlString: "https://atilim-759xz.ondigitalocean.app/fineartsMidExams", navigationTitle: "Fine Arts"))
            }
            
            Section(header: Text("Other Departments")) {
                Text("Coming Soon")
                    .foregroundColor(.gray)
            }
        }
        .navigationBarTitle("Departments", displayMode: .inline)
    }
}

#Preview {
    NavigationView {
        ExamListView()
    }
}
