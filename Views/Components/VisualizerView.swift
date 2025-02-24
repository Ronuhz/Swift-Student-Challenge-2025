//
//  VisualizerView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 14.02.2025.
//

import SwiftUI

struct VisualizerView: View {
    let gridSize: Int
    let nodes: [[Node]]
    @Binding var startNode: Node
    @Binding var endNode: Node
    @Binding var path: [Node]
    @Binding var closedSet: Set<Node>
    @Binding var openSet: Set<Node>
    @Binding var activeBranch: [Node] // DFS
    @Binding var walls: Set<Node>
    @Binding var isRunning: Bool
    @Binding var animationSpeed: Double
    let startPathfinding: () -> Void
   
    @Environment(\.audio) private var audio
    @Environment(\.character) private var character
    @Environment(\.colorScheme) private var colorScheme
    
    var noPath: Bool {
        !isRunning && (path.isEmpty && !closedSet.isEmpty)
    }
    var statusText: String {
        isRunning ? "Finding path..." :
        noPath ? "No path found" :
        "Path length: \(path.count)"
    }
    
    var body: some View {
        GeometryReader { proxy in
            let availableSize = min(proxy.size.width, proxy.size.height) * 0.8
            let cellSize = availableSize / CGFloat(gridSize)
            let isLandscape = proxy.size.width < proxy.size.height
            
            VStack(spacing: 16) {
                Grid(horizontalSpacing: 1, verticalSpacing: 1) {
                    ForEach(0..<gridSize, id: \.self) { y in
                        GridRow {
                            ForEach(0..<gridSize, id: \.self) { x in
                                let node = nodes[y][x]
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(nodeColor(for: node))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .strokeBorder(.primary.opacity(0.2), lineWidth: 1)
                                        }
                                    
                                    if node == startNode {
                                        Text(character.current.icon)
                                            .font(.system(size: cellSize * 0.8))
                                    } else if node == endNode {
                                        Text(character.current.looksFor.icon)
                                            .font(.system(size: cellSize * 0.8))
                                    }
                                }
                                .frame(width: cellSize, height: cellSize)
                                .onTapGesture {
                                    audio.play(.tap)
                                    if !isRunning {
                                        toggleWall(at: node)
                                    }
                                }
                            }
                        }
                    }
                }
                
                if isLandscape {
                    Spacer()
                }
                NoteView("Tap a cell to place a wall, or press Randomize", systemImage: "info.circle.fill")
                
                HStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(statusText)
                            .font(.title3.bold())
                            .foregroundStyle(noPath ? .red : .primary)
                            .contentTransition(.numericText())
                            .animation(.spring, value: isRunning)
                        
                        HStack(spacing: 12) {
                            Text("Speed")
                                .font(.subheadline.bold())
                                .foregroundStyle(.secondary)
                            
                            Slider(value: $animationSpeed, in: 0.1...2.0)
                                .tint(.accentColor)
                        }
                    }


                    HStack(spacing: 12) {
                        Button("Randomize") {
                            generateMaze()
                            audio.play(.tap)
                        }
                        .disabled(isRunning)
                        .buttonStyle(ActionButton())
                        
                        Button(isRunning ? "Reset" : "Find Path") {
                            audio.play(.tap)
                            if isRunning {
                                resetVisualization()
                            } else {
                                resetVisualization()
                                startPathfinding()
                                audio.play(.waiting, in: .background)
                            }
                        }
                        .buttonStyle(ActionButton())
                        .contentTransition(.numericText())
                    }
                }
                .animation(.spring, value: isRunning)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaPadding([.horizontal, .bottom])
            .onDisappear {
                audio.stop(in: .background)
            }
            .onChange(of: isRunning) { _, newValue in
                if newValue == false {
                    audio.stop(in: .background)
                    if noPath {
                        audio.play(.failure)
                    } else if path.count > 0 {
                        audio.play(.success)
                    }
                }
            }
        }
    }
    
//    MARK: - Helper Functions
    private func toggleWall(at node: Node) {
        if node == startNode || node == endNode { return }
        if walls.contains(node) {
            walls.remove(node)
        } else {
            walls.insert(node)
        }
    }
    
    private func nodeColor(for node: Node) -> Color {
        if node == startNode { return .green }
        if node == endNode { return .red }
        if walls.contains(node) { return colorScheme == .light ? .black : .white }
        if path.contains(node) { return .yellow }
        if openSet.contains(node) { return .blue.opacity(0.5) }
        if activeBranch.contains(node) { return .blue.opacity(0.5) }
        if closedSet.contains(node) { return .gray.opacity(0.5) }
        return Color(uiColor: .systemBackground)
    }
    
    private func resetVisualization() {
        isRunning = false
        openSet.removeAll()
        activeBranch.removeAll() // DFS
        closedSet.removeAll()
        path.removeAll()
        
        for row in nodes {
            for node in row {
                node.g = Double.infinity
                node.f = Double.infinity
                node.parent = nil
            }
        }
    }
    
//    MARK: - Maze generation
    private func generateMaze() {
        guard !isRunning else { return }
        resetVisualization()
        walls.removeAll()
        
        // Randomly select start and end nodes
        let flatNodes = nodes.flatMap { $0 }
        guard let newStart = flatNodes.randomElement(),
              let newEnd = flatNodes.randomElement(),
              newStart != newEnd else { return }
        
        startNode = newStart
        endNode = newEnd
        
        for row in nodes {
            for node in row {
                if node == startNode || node == endNode {
                    continue
                }
                
                if Double.random(in: 0...1) < 0.3 {
                    walls.insert(node)
                }
            }
        }
    }

}

