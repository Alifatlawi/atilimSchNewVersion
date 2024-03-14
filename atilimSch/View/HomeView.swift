//
//  HomeView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isShowCoursesViewPresented = false
    @State private var isShowEditCoursesViewPresented = false
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Control Your\nCourses & Exams")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.leading)
                        Image("mainpic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenSize.height * 0.2)
                            .offset(x: 10)
                            .padding(.trailing)
                            
                    }
//                    .padding(10)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.1), Color.gray.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(.rect(cornerRadius: 15))
                    .shadow(radius: 5)
                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal)
                    
                    // Cards section
                    VStack(alignment: .leading, spacing: 20) {
                        
                        
                        NavigationLink {
                            SelectScheduleTypeView()
                        } label: {
                            CardView(title: "Make Schedule", image: "courses", text: "Generate your schedule automatically or create it manually.")
                                .background(LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.4), Color.red.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        
                        
                        NavigationLink {
                            EditCoursesView()
                        } label: {
                            CardView(title: "Edit Schedule", image: "editcour", text: "Edit, delete, or modify your schedule here.")
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.4), Color.blue.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(.rect(cornerRadius: 15))
                        }

                        
//                        Button(action: {isShowEditCoursesViewPresented = true}, label: {
//                            CardView(title: "Edit Schedule", image: "editcour", text: "Edit, delete, or modify your schedule here.")
//                                .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.4), Color.blue.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                                .clipShape(.rect(cornerRadius: 15))
//                        })
//                        .sheet(isPresented: $isShowEditCoursesViewPresented, content: {
//                            EditCoursesView()
//                        })
                        
                        
                        NavigationLink {
                            ExamView()
                        } label: {
                            CardView(title: "Exams", image: "mainpic", text: "Now you can track your Exams !")
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.red.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .clipShape(.rect(cornerRadius: 15))
                        }
                        
                    }
                    .padding()
                }
            }
        }
        .background(Color.secondary.opacity(0.1))
    }
}


#Preview {
    HomeView()
}
