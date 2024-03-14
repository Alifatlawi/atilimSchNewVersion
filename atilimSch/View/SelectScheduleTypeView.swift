//
//  SelectScheduleTypeView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct SelectScheduleTypeView: View {
    let screenSize = UIScreen.main.bounds.size
    @State private var showManualView = false
    @State private var showAutoView = false
    var body: some View {
        ZStack {
            StarAnimationView()
                .ignoresSafeArea()
            VStack {
                HStack {
                    
                    Text("LET'S WORK ON YOUR SCHEDULE")
                        .font(Font.custom("Bebas Neue", size: 45))
                    
                    headerImage
                }
                .frame(maxWidth: .infinity, maxHeight: screenSize.height * 0.2)
                
                NavigationLink(destination: AutuScheduleView()) {
                    optionCard(
                        title: "Automatic",
                        description: "Let us generate the schedule for you. Just select your courses, and we'll do the rest!",
                        imageName: "mkc"
                    )
                    .padding(.vertical)
                }
                
//                Button(action: {showAutoView = true}, label: {
//                    optionCard(
//                        title: "Automatic",
//                        description: "Let us generate the schedule for you. Just select your courses, and we'll do the rest!",
//                        imageName: "mkc"
//                    )
//                    .padding(.vertical)
//                })
//                .sheet(isPresented: $showAutoView) {
//                    AutuScheduleView()
//                }
                
                NavigationLink {
                    ManualScheduleView()
                } label: {
                    optionCard(
                        title: "Manual",
                        description: "Select your courses and create your own schedule manually.",
                        imageName: "mkc1",
                        isImageLeading: true
                    )
                }

                
                
//                Button(action: {
//                    showManualView = true
//                }) {
//                    optionCard(
//                        title: "Manual",
//                        description: "Select your courses and create your own schedule manually.",
//                        imageName: "mkc1",
//                        isImageLeading: true
//                    )
//                }
//                .sheet(isPresented: $showManualView) {
//                    ManualScheduleView()
//                }
            }
        }
    }
    
    var headerImage: some View {
        Image("group") // Ensure the image name is correct
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenSize.width * 0.5)
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
        SelectScheduleTypeView()
    }
}
