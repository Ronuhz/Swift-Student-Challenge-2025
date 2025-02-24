//
//  SwiftUIView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.audio) private var audio
    @Environment(\.phase) private var phase
    
    @State private var isVisible = false
    @State private var isShowingCreditsView = false
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading,spacing: 30) {
                Text("Lost? Let’s Find the Way!")
                    .title()
                    .offset(y: isVisible ? 0 : 90)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.smooth, value: isVisible)

                Text("*Ever found yourself wandering aimlessly? Let’s explore how pathfinding helps us navigate both in apps and in life.*")
                    .subtitle()
                    .offset(y: isVisible ? 0 : 90)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.smooth.delay(0.3), value: isVisible)
                    .frame(maxWidth: proxy.size.width * 0.85, alignment: .leading)

                
                Button("Show Me the Path →") {
                    phase.next()
                    audio.play(.tap)
                }
                .buttonStyle(ActionButton())
                .offset(y: isVisible ? 0 : 90)
                .opacity(isVisible ? 1 : 0)
                .animation(.smooth.delay(0.6), value: isVisible)
                
                if proxy.size.width < proxy.size.height {
                    NoteView("Landscape orientation recommended for best experience", systemImage: "rotate.right")
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .padding()
            .onAppear {
                isVisible = true
            }
        }
        .fullScreenCover(isPresented: $isShowingCreditsView, content: CreditsView.init)
        .overlay {
            if isVisible {
                Button("Credits", systemImage: "info.circle.fill") {
                    isShowingCreditsView = true
                    audio.play(.tap)
                }
                .buttonStyle(ActionButton())
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
                .ignoresSafeArea()
            }
        }
    }
}



#Preview {
    WelcomeView()
        .preview()
}

