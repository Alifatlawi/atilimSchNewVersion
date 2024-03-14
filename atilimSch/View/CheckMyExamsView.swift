import SwiftUI
import CoreData

struct CheckMyExamsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: ExamEntity.entity(),
        sortDescriptors: []
    ) var exams: FetchedResults<ExamEntity>
    
    @State private var showingDeleteError = false

    private var sortedExams: [ExamEntity] {
        exams.sorted {
            guard let date1 = $0.dateAsDate, let date2 = $1.dateAsDate else { return false }
            return date1 < date2
        }
    }
    
    var body: some View {
        Group {
            if exams.isEmpty {
                Text("No exams added yet")
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(sortedExams, id: \.self) { exam in
                        ExamCardView(exam: exam)
                    }
                    .onDelete(perform: deleteExam)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationBarTitle("My Exams", displayMode: .inline)
        .toolbar {
            EditButton()
        }
        .alert(isPresented: $showingDeleteError) {
            Alert(title: Text("Error"), message: Text("There was an error deleting the exam."), dismissButton: .default(Text("OK")))
        }
    }
    
    func deleteExam(at offsets: IndexSet) {
        for index in offsets.map({ sortedExams[$0] }) {
            let exam = index
            moc.delete(exam)
        }
        
        do {
            try moc.save()
        } catch {
            showingDeleteError = true
            print("There was an error deleting the exam: \(error.localizedDescription)")
        }
    }
}

struct ExamCardView: View {
    var exam: ExamEntity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(.accentColor)
                    Text(exam.courseCode?.uppercased() ?? "Unknown Course")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }

                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                    Text("Date: \(exam.date ?? "Unknown Date")")
                        .foregroundColor(.secondary)
                }

                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.secondary)
                    Text("Time: \(exam.time ?? "Unknown Time")")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}


// Make sure to adjust this preview provider to fit your project's setup
struct CheckMyExamsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckMyExamsView()
        }
    }
}


extension ExamEntity {
    var dateAsDate: Date? {
        guard let dateString = self.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: dateString)
    }
}
