import SwiftUI
import CoreData

struct CheckMyExamsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: ExamEntity.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ExamEntity.date, ascending: true)
        ]
    ) var exams: FetchedResults<ExamEntity>
    
    @State private var showingDeleteError = false
    
    var body: some View {
        Group {
            if exams.isEmpty {
                Text("No exams added yet")
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(exams, id: \.self) { exam in
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
        for index in offsets {
            let exam = exams[index]
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
            VStack(alignment: .leading, spacing: 10) {
                Text(exam.courseCode?.uppercased() ?? "Unknown Course")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Date: \(exam.date ?? "Unknown Date")")
                Text("Time: \(exam.time ?? "Unknown Time")")
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(.horizontal)
        .padding(.vertical, 4)
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
