//
//  AutuScheduleView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct AutuScheduleView: View {
    @State private var courses = [Course]() // Replace Course with your model
    @State private var filteredCourses = [Course]()
    @State private var addedCourseIds = Set<String>()
    @State private var searchText = ""
    @State private var isLoading = true
    @State private var showReviewScreen = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                } else {
                    List(filteredCourses, id: \.id) { course in
                        HStack {
                            Text(course.id)
                                .foregroundColor(.primary)
                            Spacer()
                            Button(action: {
                                toggleCourse(course)
                            }) {
                                Image(systemName: addedCourseIds.contains(course.id) ? "minus.circle" : "plus.circle")
                                    .foregroundColor(addedCourseIds.contains(course.id) ? .red : .blue)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .sheet(isPresented: $showReviewScreen) {
                ReviewScheduleView(selectedCourseIds: $addedCourseIds)
            }
            .onAppear(perform: loadData)
            .searchable(text: $searchText, prompt: "Search for courses")
            .onChange(of: searchText) { newValue in
                filterCourses(with: newValue)
            }
            .navigationTitle("Courses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    addedCourseIds.isEmpty ? nil : Button("Next", role: .destructive) {
                        showReviewScreen = true
                    }
                }
                
            }
            
        }
    }
    
    private func loadData() {
        isLoading = true
        // Replace DataService with your data fetching service
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
            filteredCourses = courses.filter { $0.id.contains(query) }
        }
    }
    
    private func toggleCourse(_ course: Course) {
        if addedCourseIds.contains(course.id) {
            addedCourseIds.remove(course.id)
        } else {
            addedCourseIds.insert(course.id)
        }
    }
    
    private func createSchedule() {
        // Implement schedule creation logic here
        print("Creating schedule with courses: \(addedCourseIds)")
    }
}

#Preview {
    AutuScheduleView()
}
