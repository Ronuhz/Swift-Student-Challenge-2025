//
//  Debriefing.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 05.02.2025.
//

import SwiftUI

struct DebriefingView: View {
    @Environment(\.audio) private var audio
    @Environment(\.character) private var character
    @Environment(\.phase) private var phase
    
    @State private var selectedAlgorithm: Algorithm?
    @State private var isVisible = false
    @State private var showCertificateView: Bool = false
    
    @AppStorage("A*") private var AStarCompleted: Bool = false
    @AppStorage("Dijkstra") private var DijkstraCompleted: Bool = false
    @AppStorage("DFS") private var DFSCompleted: Bool = false
    
    @Namespace private var zoomTransitionNamespace
    
    var certificateUnlocked: Bool {
        AStarCompleted && DijkstraCompleted && DFSCompleted
    }
        
    var body: some View {
        NavigationStack {
            ZStack {
//                Need to do it again because the NavigationStack overwrites the GridBackgroundView in ContentView
                GridBackgroundView()
                
                VStack(alignment: .leading, spacing: 24) {
                    if isVisible {
                        Text("Debriefing")
                            .title()
                            .transition(RevealByRunSlice())
                        
                        Text("""
    *Meet* **\(character.current.icon) \(character.current.name)**!  
    *Their mission? To find **\(character.current.looksFor.icon) \(character.current.looksFor.name.lowercased())** hidden deep within this maze.  
    But how will they get there? That’s up to you! Choose a pathfinding strategy to guide them through the challenge. Try all for a special reward!*
    """)
                        .subtitle()
                        .multilineTextAlignment(.leading)
                        .transition(RevealByRunSlice())
                    }
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 500, maximum: 800), spacing: 40)], spacing: 40) {
                                ForEach(Array(Algorithm.all.enumerated()), id: \.offset) { index, algorithm in
                                    Button {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            selectedAlgorithm = algorithm
                                        }
                                        audio.play(.tap)
                                    } label: {
                                        AlgorithmCard(for: algorithm, isSelected: selectedAlgorithm?.id == algorithm.id)
                                            .padding(20) // fixes wierd border clipping with matchedTransitionSource
                                            .matchedTransitionSource(id: algorithm.type, in: zoomTransitionNamespace)
                                            .padding(-20) // remove the padding after, so layout stays intact
                                            .shadow(color: .primary.opacity(0.1), radius: 8, y: 4)

                                    }
                                    .buttonStyle(.plain)
                                    .transition(.move(edge: .top).combined(with: .opacity))
                                    .opacity(isVisible ? 1 : 0)
                                    .offset(y: isVisible ? 0 : 50)
                                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(Double(index) * 0.1), value: isVisible)
                                }
                            }
                            .padding(.vertical, 10)
                            
                            NoteView("You can return here anytime", systemImage: "info.circle.fill")
                        }
                    }
                    .scrollBounceBehavior(.basedOnSize)
                    .padding(.vertical, -10)
                    
                    if certificateUnlocked {
                        Button("Claim Certificate") {
                            audio.play(.tap)
                            showCertificateView = true
                        }
                        .buttonStyle(ActionButton(edgeToEdge: true, color: Color.green.gradient))
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    
                    if let selectedAlgorithm {
                        NavigationLink(value: selectedAlgorithm) {
//                        Using a Button instead of a Text, because ActionButton is a ButtonStyle and not a ViewModifier, but disabled hit testing on it so the NavigationLink gets priority
                            Button("Let's Try \(selectedAlgorithm.name) →") {}
                                .buttonStyle(ActionButton(edgeToEdge: true))
                                .allowsHitTesting(false)
                        }
//                        Workaround to play audio onTap on the NavigationLink
                        .simultaneousGesture(TapGesture().onEnded({
                            audio.play(.tap)
                        }))
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .navigationDestination(for: Algorithm.self) { algorithm in
                    AlgorithmPlaygroundView(algorithm: algorithm)
                        .navigationTransition(.zoom(sourceID: algorithm.type, in: zoomTransitionNamespace))
                }
                .safeAreaPadding()
                .task {
//                Can't use onAppear because then only the first element will be animated in the LazyVGrid thanks to something wierd happening with NavigationStack
                    isVisible = true
                }
                .fullScreenCover(isPresented: $showCertificateView, content: CertificateView.init)
            }
        }
    }
}

#Preview {
    DebriefingView()
        .preview()
}
