//
//  DijkstraPathfindingView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 11.02.2025.
//

import SwiftUI

struct DijkstraPathfindingView: View {
    @State private var state = PathfindingState(
        gridSize: 15,
        startX: 2,
        startY: 2,
        endX: 1,
        endY: 12
    )
        
    var body: some View {
        VisualizerView(
            gridSize: state.gridSize,
            nodes: state.nodes,
            startNode: $state.startNode,
            endNode: $state.endNode,
            path: $state.path,
            closedSet: $state.closedSet,
            openSet: $state.openSet,
            activeBranch: .constant([]),
            walls: $state.walls,
            isRunning: $state.isRunning,
            animationSpeed: $state.animationSpeed,
            startPathfinding: startPathfinding
        )
    }
    
//    MARK: - Dijkstra Implementation
    private func startPathfinding() {
        state.isRunning = true
        
        state.startNode.f = 0
        state.openSet = [state.startNode]
        
        Task {
            while !state.openSet.isEmpty {
                guard let current = state.openSet.min(by: { $0.f < $1.f }) else { break }
                
                if current == state.endNode {
                    reconstructPath(from: current)
                    state.isRunning = false
                    return
                }
                
                state.openSet.remove(current)
                state.closedSet.insert(current)
                
                // Explore the 4 neighboring nodes (up, down, left, right)
                for (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let newX = current.x + dx
                    let newY = current.y + dy
                    
                    // Ensure the neighbor is within bounds.
                    guard newX >= 0, newX < state.gridSize, newY >= 0, newY < state.gridSize else { continue }
                    
                    let neighbor = state.nodes[newY][newX]
                    
                    // Skip if the neighbor is a wall or already fully processed.
                    if state.walls.contains(neighbor) || state.closedSet.contains(neighbor) {
                        continue
                    }
                    
                    let tentativeF = current.f + 1
                    
                    if tentativeF < neighbor.f {
                        neighbor.parent = current
                        neighbor.f = tentativeF
                        state.openSet.insert(neighbor)
                    }
                }
                
                if state.animationSpeed != 2 {
                    try? await Task.sleep(nanoseconds: UInt64(100_000_000 / state.animationSpeed))
                }
            }
            
            state.isRunning = false
        }
        
        UserDefaults.standard.set(true, forKey: "Dijkstra")
    }
    
    private func reconstructPath(from node: Node) {
        var current: Node? = node
        var reversedPath: [Node] = []
        while let n = current, n != state.startNode {
            reversedPath.append(n)
            current = n.parent
        }
        state.path = reversedPath.reversed()
    }
}

#Preview {
    DijkstraPathfindingView()
        .preview()
}
