//
//  ExamView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 8.03.2024.
//

import SwiftUI

struct ExamView: View {
    let screenSize = UIScreen.main.bounds.size
    
    var body: some View {
            VStack {
                
                HStack{
                    Text("LET'S CHECK YOUR EXAMS !")
                        .font(Font.custom("Bebas Neue", size: 45))
                        .padding()
                    
                    Image("editcour") // Make sure the image name is correct and the image is included in your assets.
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenSize.height * 0.2)
                }
                
                NavigationLink {
                    ExamListView()
                } label: {
                    optionCard(title: "View Exams", description: "See all available exams", imageName: "mainpic", isImageLeading: true)
                }
                
                NavigationLink {
                    CheckMyExamsView()
                } label: {
                    optionCard(title: "Check My Exams", description: "Review exams you've taken", imageName: "mkc1", isImageLeading: false)
                }
            }
            .navigationTitle("Exams")
            .navigationBarTitleDisplayMode(.inline)
        }
    
    func optionCard(title: String, description: String, imageName: String, isImageLeading: Bool = false) -> some View {
        HStack {
            if isImageLeading { optionImage(imageName: imageName) }
            optionText(title: title, description: description)
            if !isImageLeading { optionImage(imageName: imageName) }
        }
        .frame(maxWidth: .infinity, maxHeight: screenSize.height * 0.2)
        .background(.regularMaterial)
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    func optionImage(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: screenSize.width * 0.3, maxHeight: screenSize.height * 0.15)
            .padding(.horizontal)
    }
    
    func optionText(title: String, description: String) -> some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Text(description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

#Preview {
    NavigationView{
        ExamView()
    }
}
