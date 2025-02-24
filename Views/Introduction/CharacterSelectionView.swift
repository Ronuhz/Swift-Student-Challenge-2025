//
//  CharacterSelection.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct CharacterSelectionView: View {
    @State private var selectedFigure: Figure?
    
    @Environment(\.audio) private var audio
    @Environment(\.character) private var character
    @Environment(\.phase) private var phase
    @State private var isVisible = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if isVisible {
                Text("Pick Your Pathfinder!")
                    .title()
                    .transition(RevealByRunSlice())
                
                Text("*Before we send you into the maze, you need a hero! Who's going to be navigating this wild world of corridors and dead ends? Choose wisely!*")
                    .subtitle()
                    .transition(RevealByRunSlice())
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 500, maximum: 800), spacing: 40)], spacing: 40) {
                    ForEach(Array(Character.all.enumerated()), id: \.offset) { index, figure in
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedFigure = figure
                            }
                            audio.play(.tap)
                        } label: {
                            FigureCard(figure: figure, isSelected: selectedFigure?.id == figure.id)
                        }
                        .buttonStyle(.plain)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .opacity(isVisible ? 1 : 0)
                        .offset(y: isVisible ? 0 : 50)
                        .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(Double(index) * 0.1), value: isVisible)
                    }
                }
                .padding(.top, 10) // I love shadows
            }
            .scrollBounceBehavior(.basedOnSize)
            .padding(.top, -10) // I love shadows
            
            if let selectedFigure {
                Button("Start Adventure with \(selectedFigure.name) →") {
                    character.save(selectedFigure)
                    phase.next()
                    audio.play(.tap)
                }
                .buttonStyle(ActionButton(edgeToEdge: true))
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .safeAreaPadding()
        .onAppear {
            isVisible = true
        }
    }
}


#Preview {
    CharacterSelectionView()
        .preview()
}
