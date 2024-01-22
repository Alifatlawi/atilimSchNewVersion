import Foundation

class GenerateScheduleViewModel: ObservableObject {
    @Published var scheduleOptions: Welcome = [] // Adjusted to use the Welcome alias
    @Published var isDataLoaded = false
    private var courseService = CourseService()

    func loadScheduleOptions(courseIds: [String]) {
        isDataLoaded = false // Reset the flag
        courseService.fetchCourseDetails(courseIds: courseIds) { [weak self] fetchedScheduleOptions, error in
            DispatchQueue.main.async {
                if let fetchedScheduleOptions = fetchedScheduleOptions {
                    self?.scheduleOptions = fetchedScheduleOptions
                    self?.isDataLoaded = true // Set the flag on successful fetch
                } else if let error = error {
                    print("Error fetching schedule options: \(error)")
                    self?.isDataLoaded = false
                }
            }
        }
    }
}
