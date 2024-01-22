//
//  CardView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 21.01.2024.
//

import SwiftUI


struct CardView: View {
    var title: String
    var image: String
    var text: String

    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        ZStack {
            Color.gray.opacity(0.3)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)

            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(text)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: screenSize.width * 0.2, maxHeight: screenSize.height * 0.15)
            }
            .frame(width: screenSize.width * 0.8, height: screenSize.height * 0.17) // Adjust the width and height of the HStack
            .padding() 
        }
        .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.17) // Adjust the width and height of the ZStack
        .cornerRadius(15)
    }
}


#Preview {
    CardView(title: "make schule", image: "courses", text: "u can make your schedule here ")
}
