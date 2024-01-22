import SwiftUI

struct MatrixView: View {
    let screenSize = UIScreen.main.bounds.size
    let constant = "0101010101010101010100101010101010101010101010101"

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            HStack(spacing: 10) {
                ForEach(1...Int(size.width / 25), id: \.self) { _ in
                    RainCharacters(size: size, constant: constant)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct RainCharacters: View {
    var size: CGSize
    var constant: String

    @State var startAnimation: Bool = false
    @State var random: Int = 0

    var body: some View {
        let randomHeight: CGFloat = .random(in: (size.height / 2)...size.height)

        VStack {
            ForEach(0..<constant.count, id: \.self) { index in
                let character = Array(constant)[getRandomIndex(index: index, max: constant.count)]
                Text(String(character))
                    .font(.system(size: 25, weight: .light, design: .monospaced))
            }
        }
        .mask(alignment: .top) {
            Rectangle()
                .fill(
                    LinearGradient(colors: [.clear,
                                            .black.opacity(0.1),
                                            .black.opacity(0.2),
                                            .black.opacity(0.3),
                                            .black.opacity(0.5),
                                            .black.opacity(0.7),
                                            .black
                                           ], startPoint: .top, endPoint: .bottom)
                )
                .frame(height: size.height / 2)
                .offset(y: startAnimation ? size.height : -randomHeight)
        }
        .onAppear {
            withAnimation(.linear(duration: 2).delay(.random(in: 0...2)).repeatForever(autoreverses: false)) {
                startAnimation = true
            }
        }
        .onReceive(Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()) { _ in
            random = Int.random(in: 0..<constant.count)
        }
    }

    func getRandomIndex(index: Int, max: Int) -> Int {
        let newIndex = (index + random) % max
        return newIndex >= 0 ? newIndex : newIndex + max
    }
}

struct MatrixView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixView()
    }
}
