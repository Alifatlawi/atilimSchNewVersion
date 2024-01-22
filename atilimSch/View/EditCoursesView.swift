import SwiftUI
import CoreData

struct EditCoursesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: CourseEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CourseEntity.name, ascending: true)]
    ) var courses: FetchedResults<CourseEntity>

    @State private var showingDeleteError = false
    @Environment(\.presentationMode) var presentationMode  // To control the dismissal of the view

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
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: EditButton()
            )
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
    @State private var selectedColor: Color
    @Environment(\.managedObjectContext) var moc
    @State private var showingSaveAlert = false

    init(course: CourseEntity) {
        self.course = course
        if let colorHex = course.color, let uiColor = UIColor(hex: colorHex) {
            _selectedColor = State(initialValue: Color(uiColor))
        } else {
            _selectedColor = State(initialValue: .blue) // Default color
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Course Information")) {
                    Text("ID: \(course.id ?? "")")
                    Text("Name: \(course.name ?? "")")
                    ColorPicker("Select Color", selection: $selectedColor)
                }
                // Additional sections and details can be added here
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(course.name ?? "Unknown Course")
            .navigationBarItems(trailing: Button("Save") {
                updateCourseColor()
            })
            .alert(isPresented: $showingSaveAlert) {
                Alert(title: Text("Saved"), message: Text("Course color updated successfully. \nYou need to restart the application so see the results"), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func updateCourseColor() {
        course.color = selectedColor.toHex()
        do {
            try moc.save()
            showingSaveAlert = true
        } catch {
            print("Error saving color: \(error)")
        }
    }
}
// For Preview
struct EditCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        EditCoursesView()
    }
}

extension UIColor {
    convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        return nil
    }
}
