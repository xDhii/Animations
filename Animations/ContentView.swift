//
//  ContentView.swift
//  Animations
//
//  Created by Adriano Valumin on 10/25/23.
//

import SwiftUI

struct CornerRotateMofidier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateMofidier(amount: -90, anchor: .topLeading), identity: CornerRotateMofidier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    let letters = Array("Hello SwiftUI")

    @State private var animationAmount = 1.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        ZStack {
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 200, height: 200)

                        if enabled {
                            Rectangle()
                                .fill(.red)
                                .frame(width: 200, height: 200)
                                .transition(.pivot)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            enabled.toggle()
                        }
                    }
                }

                VStack {
                    Button("Tap me") {
                        withAnimation {
                            enabled.toggle()
                        }
                    }
                    if enabled {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 200, height: 200)
                            .transition(.asymmetric(insertion: .scale, removal: .opacity))
                    }
                }

                ZStack {
                    Button("") {
                        enabled.toggle()
                    }
                    .frame(width: 300, height: 200)
                    .background(enabled ? .blue : .red)
                    .foregroundStyle(.white)
                    .animation(.default, value: enabled) // animates only the background color transition
                    .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
                    .animation(.spring(duration: 1, bounce: 0.6), value: enabled) // animates only the clipShape
                    .border(Color.black, width: enabled ? 0 : 3)
                    .animation(.easeIn, value: enabled) // animates only the border

                    HStack(spacing: 0) {
                        ForEach(0 ..< letters.count, id: \.self) { num in
                            Text(String(letters[num]))
                                .padding(5)
                                .font(.title)

                                .clipShape(.rect(cornerRadius: 1))
                                .offset(dragAmount)
                                .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                        }
                    }
                    .background(enabled ? .red : .blue).gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                dragAmount = .zero
                                enabled.toggle()
                            }
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
