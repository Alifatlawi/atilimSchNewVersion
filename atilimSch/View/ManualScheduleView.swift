//
//  ManualScheduleView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct ManualScheduleView: View {
    @State private var courses = [Course]()
    @State private var filteredCourses = [Course]()
    @State private var searchText = ""
    @State private var isLoading = true
    let screenSize = UIScreen.main.bounds.size
    //    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
            } else {
                List(filteredCourses, id: \.id) { course in
                    NavigationLink(destination: CourseDetailView(course: course)) {
                        Text(course.id)
                            .foregroundColor(.primary)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear(perform: loadData)
        .searchable(text: $searchText, prompt: "Search for courses")
        .onChange(of: searchText) { newValue in
            filterCourses(with: newValue)
        }
        .navigationTitle("Courses")
        .navigationBarTitleDisplayMode(.inline)
        //            .toolbar(content: {
        //                ToolbarItem(placement: .topBarLeading) {
        //                    Button("Cancel", role: .cancel){
        //                        dismiss()
        //                    }
        //                }
        //            })
        
    }
    
    private func loadData() {
        isLoading = true
        DataService().fetchCourses { fetchedCourses in
            if let fetchedCourses = fetchedCourses {
                self.courses = fetchedCourses
                self.filteredCourses = fetchedCourses
            }
            isLoading = false
        }
    }
    
    private func filterCourses(with query: String) {
        if query.isEmpty {
            filteredCourses = courses
        } else {
            // Convert both search query and course id to lower case for case-insensitive comparison
            filteredCourses = courses.filter { $0.id.lowercased().contains(query.lowercased()) }
        }
    }
}


#Preview {
    NavigationView{
        ManualScheduleView()
    }
}
