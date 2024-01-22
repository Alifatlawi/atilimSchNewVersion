//import SwiftUI
//
//struct ScheduleOptionsView: View {
//    var scheduleOptions: [[[Course]]]
//    @State private var selectedOptionIndex = 0
//
//    var body: some View {
//        VStack {
//            if scheduleOptions.indices.contains(selectedOptionIndex) {
//                List {
//                    ForEach(scheduleOptions[selectedOptionIndex], id: \.self) { courseGroup in
//                        ForEach(courseGroup, id: \.id) { course in
//                            VStack(alignment: .leading) {
//                                Text(course.courseName)
//                                    .font(.headline)
//                                ForEach(course.section.schedules, id: \.startTime) { schedule in
//                                    Text("\(schedule.day) \(schedule.startTime)-\(schedule.endTime) in \(schedule.classroom)")
//                                        .font(.subheadline)
//                                }
//                            }
//                            Divider()
//                        }
//                    }
//                }
//            } else {
//                Text("No schedule options available.")
//            }
//
//            HStack {
//                Button("Previous") {
//                    if selectedOptionIndex > 0 {
//                        selectedOptionIndex -= 1
//                    }
//                }
//                .disabled(selectedOptionIndex <= 0)
//
//                Spacer()
//
//                Button("Next") {
//                    if selectedOptionIndex < scheduleOptions.count - 1 {
//                        selectedOptionIndex += 1
//                    }
//                }
//                .disabled(selectedOptionIndex >= scheduleOptions.count - 1)
//            }
//            .padding()
//        }
//        .padding()
//        .navigationTitle("Schedule Options (\(selectedOptionIndex + 1)/\(scheduleOptions.count))")
//    }
//}
//
//
////#Preview {
////    ScheduleOptionsView()
////}
