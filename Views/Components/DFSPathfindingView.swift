//
//  DFSPathfindingView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct DFSPathfindingView: View {
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
            openSet: .constant([]),
            activeBranch: $state.activeBranch,
            walls: $state.walls,
            isRunning: $state.isRunning,
            animationSpeed: $state.animationSpeed,
            startPathfinding: startPathfinding
        )
    }
    
    // MARK: - DFS Implementation
    private func startPathfinding() {
        state.isRunning = true
        
        state.activeBranch = [state.startNode]
        
        Task {
            while !state.activeBranch.isEmpty {
                guard let current = state.activeBranch.last else { break }
                
                if current == state.endNode {
                    reconstructPath(from: current)
                    state.isRunning = false
                    return
                }
                
                var foundNeighbor = false
                // Check neighbors in 4 directions
                for (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let newX = current.x + dx
                    let newY = current.y + dy
                    
                    guard newX >= 0, newX < state.gridSize, newY >= 0, newY < state.gridSize else { continue }
                    let neighbor = state.nodes[newY][newX]
                    
                    if state.walls.contains(neighbor) || state.closedSet.contains(neighbor) || state.activeBranch.contains(neighbor) {
                        continue
                    }
                    
                    neighbor.parent = current
                    state.activeBranch.append(neighbor)
                    foundNeighbor = true
                    break
                }
                
                if !foundNeighbor {
                    let deadEnd = state.activeBranch.removeLast()
                    state.closedSet.insert(deadEnd)
                }
                
                // Slow down the algorithm for visualization purposes
                if state.animationSpeed != 2 {
                    try? await Task.sleep(nanoseconds: UInt64(100_000_000 / state.animationSpeed))
                }
            }
            
            state.isRunning = false
        }
        
        UserDefaults.standard.set(true, forKey: "DFS")
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
    DFSPathfindingView()
        .preview()
}
