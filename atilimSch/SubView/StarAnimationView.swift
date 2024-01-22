//
//  StarAnimationView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import SwiftUI

struct Star {
    var position: CGPoint
    var velocity: CGFloat
}


struct StarAnimationView: View {
    @State private var stars: [Star] = []
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common)
        .autoconnect()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var body: some View {
        Canvas { context, size in
            for star in stars {
                let conterxCopy = context
                let rect = CGRect(x: star.position.x, y: star.position.y, width: 2, height: 2)
                conterxCopy.fill(Path(ellipseIn: rect), with: .color(.white))
            }
        }
        .background(Color.black)
        .onAppear(perform: {
            for _ in 0..<100 {
                let star = Star(position: CGPoint(x: CGFloat.random(in: 0...screenWidth), y: CGFloat.random(in: 0...screenHeight)), velocity: CGFloat.random(in: 2...5) 
                )
                stars.append(star)
            }
        })
        .onReceive(timer, perform: { _ in
            for i in 0..<stars.count {
                stars[i].position.y += stars[i].velocity
                if stars[i].position.y > screenHeight {
                    stars[i].position = CGPoint(x: CGFloat.random(in: 0...screenWidth), y: 0)
                }
            }
        })
    }
}

#Preview {
    StarAnimationView()
}
