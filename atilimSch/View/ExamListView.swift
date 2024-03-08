
import SwiftUI

struct ExamListView: View {
    var body: some View {
        List {
            Section(header: Text("Exams")) {
                NavigationLink("Engineering Exams", destination: EngExamListView())
                NavigationLink("General Exams", destination: GenExamView())
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
