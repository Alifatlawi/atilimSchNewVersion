////
////  GenExamView.swift
////  atilimSch
////
////  Created by BLG-BC-018 on 8.03.2024.
////
//
//import SwiftUI
//
//struct GenExamView: View {
//    @Environment(\.managedObjectContext) var moc
//    @State private var exams = [ExamsModel]()
//    @State private var isLoading = false
//    @State private var addedExams: Set<String> = []
//    @State private var searchText = ""
//
//    
//    var body: some View {
//        List(exams.filter { searchText.isEmpty ? true : $0.courseCode.localizedCaseInsensitiveContains(searchText) }) { exam in
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(exam.courseCode.uppercased()) // Change to uppercase
//                        .font(.headline)
//                    Text("Date: \(exam.date)")
//                        .font(.subheadline)
//                    Text("Time: \(exam.time)")
//                        .font(.subheadline)
//                }
//                Spacer()
//                Button(action: {
//                    saveExam(exam)
//                }) {
//                    Image(systemName: addedExams.contains(exam.courseCode) ? "checkmark.circle.fill" : "plus.circle.fill")
//                        .foregroundColor(addedExams.contains(exam.courseCode) ? .blue : .green)
//                }
//                .disabled(addedExams.contains(exam.courseCode))
//            }
//        }
//        .onAppear {
//            loadExams()
//        }
//        .navigationBarTitle("General Exams", displayMode: .inline)
//        .searchable(text: $searchText, prompt: "Search Exams")
//        .overlay {
//            if isLoading {
//                ProgressView("Loading...")
//            }
//        }
//    }
//    
//    func loadExams() {
//        isLoading = true
//        GetExams().fetchGenExams { fetchedExams in
//            exams = fetchedExams
//            isLoading = false
//        }
//    }
//    
//    func saveExam(_ examModel: ExamsModel) {
//        let examEntity = ExamEntity(context: moc)
//        examEntity.courseCode = examModel.courseCode
//        examEntity.date = examModel.date
//        examEntity.time = examModel.time
//        examEntity.id = UUID()
//        
//        do {
//            try moc.save()
//            print("Exam saved successfully!")
//            addedExams.insert(examModel.courseCode) // Mark as added
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
//
//}
//
//#Preview {
//    NavigationView {
//        GenExamView()
//    }
//}
