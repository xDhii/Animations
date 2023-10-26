//
//  ContentView.swift
//  Animations
//
//  Created by Adriano Valumin on 10/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var animationAmount2 = 1.0
    @State private var animationAmount3 = 0.0

    var body: some View {
        VStack {
            VStack {
                Stepper("Scale amount: \(animationAmount.formatted())", value: $animationAmount2.animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1 ... 10)
                    .padding(50)
            }

            Spacer()

            Button("Hey") {
                withAnimation(.spring(duration: 1, bounce: 0.5)) {
                    animationAmount3 += 360
                }
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .rotation3DEffect(
                .degrees(animationAmount3),
                axis: (x: -1.0, y: 1.0, z: 0.0)
            )

            Spacer()

            Button("Tap me") {
                animationAmount += 1
            }
            .padding(50)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .scaleEffect(animationAmount2)
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(0.2)
                    .animation(
                        .easeInOut(duration: 2)
                            .repeatForever(autoreverses: true),
                        value: animationAmount)
            )
            .onAppear {
                animationAmount = 2
            }
        }
    }
}

#Preview {
    ContentView()
}
