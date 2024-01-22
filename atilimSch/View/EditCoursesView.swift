import SwiftUI
import CoreData

struct EditCoursesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: CourseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CourseEntity.name, ascending: true)]
    ) var courses: FetchedResults<CourseEntity>
    
    @State private var showingDeleteError = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses, id: \.id) { course in
                    NavigationLink(destination: EditCourseDetailView(course: course)) {
                        Text(course.id ?? "Unknown Course")
                    }
                }
                .onDelete(perform: deleteCourse)
            }
            .navigationBarTitle("My Courses", displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
            .alert(isPresented: $showingDeleteError) {
                Alert(title: Text("Error"), message: Text("There was an error deleting the course."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func deleteCourse(at offsets: IndexSet) {
        for index in offsets {
            let course = courses[index]
            moc.delete(course)
        }
        
        do {
            try moc.save()
        } catch {
            self.showingDeleteError = true
            print("There was an error deleting the course: \(error.localizedDescription)")
        }
    }
}

struct EditCourseDetailView: View {
    var course: CourseEntity
    
    var body: some View {
        List {
            Section(header: Text("Course Information")) {
                Text("ID: \(course.id ?? "")")
                Text("Name: \(course.name ?? "")")
            }
            // ... other details ...
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(course.name ?? "Unknown Course")
    }
}

// For Preview
struct EditCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        EditCoursesView()
    }
}
