//
//  ReviewScheduleView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct ReviewScheduleView: View {
    @Binding var selectedCourseIds: Set<String>
    @ObservedObject var viewModel = GenerateScheduleViewModel()
    @State private var showDynamicScheduleView = false
    @State private var isLoading = false  // State variable to track loading status

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ZStack {
                        MatrixView()
                        TextEffect(text: "Loading")
                    }
                } else {
                    List {
                        ForEach(selectedCourseIds.sorted(), id: \.self) { courseId in
                            HStack {
                                Text(courseId)
                                Spacer()
                                Button(action: {
                                    self.selectedCourseIds.remove(courseId)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }

                    Button("Generate Schedule") {
                        isLoading = true  // Start loading
                        viewModel.loadScheduleOptions(courseIds: Array(selectedCourseIds))
                        showDynamicScheduleView = true
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                
                // Navigation link to DynamicScheduleView
                if viewModel.isDataLoaded {
                    NavigationLink(destination: DynamicScheduleView(scheduleOptions: viewModel.scheduleOptions).navigationBarBackButtonHidden(true), isActive: $showDynamicScheduleView) {
                        EmptyView()
                    }
                    .onAppear {
                        isLoading = false  // Stop loading once data is loaded
                        showDynamicScheduleView = true
                    }
                }
            }
        }
    }
}
    
    //
    //#Preview {
    //    ReviewScheduleView()
    //}
