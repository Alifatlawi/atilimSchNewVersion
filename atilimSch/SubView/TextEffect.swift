//
//  TextEffect.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct TextEffect: View {
    let text: String
    @State private var displayCharacters = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(displayCharacters)
            .font(Font.custom("Bebas Neue", size: 45))
            .bold()
            .onReceive(timer, perform: { _ in
                if displayCharacters.count < text.count {
                    let index = text.index(text.startIndex, offsetBy: displayCharacters.count)
                    displayCharacters.append(text[index])
                }
            })
    }
}

#Preview {
    TextEffect(text: "Ali amer mirdan")
}
