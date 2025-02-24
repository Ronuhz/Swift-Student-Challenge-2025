//
//  AStarPathfindingView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct AStarPathfindingView: View {
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

    // MARK: - A* Implementation
    private func startPathfinding() {
        state.isRunning = true
        
        state.startNode.g = 0
        state.startNode.f = state.heuristic(state.startNode)
        state.openSet = [state.startNode]
        
        Task {
            while !state.openSet.isEmpty {
                // Get the node with the lowest f cost from the open set
                guard let current = state.openSet.min(by: { $0.f < $1.f }) else { break }
                
                if current == state.endNode {
                    reconstructPath(from: current)
                    state.isRunning = false
                    return
                }
                
                state.openSet.remove(current)
                state.closedSet.insert(current)
                
                // Check neighbors in 4 directions
                for (dx, dy) in [(0, 1), (1, 0), (0, -1), (-1, 0)] {
                    let newX = current.x + dx
                    let newY = current.y + dy
                    
                    // Check if neighbor is within the grid bounds
                    guard newX >= 0, newX < state.gridSize, newY >= 0, newY < state.gridSize else { continue }
                    
                    let neighbor = state.nodes[newY][newX]
                    
                    if state.walls.contains(neighbor) || state.closedSet.contains(neighbor) {
                        continue
                    }
                    
                    let tentativeG = current.g + 1
                    
                    // If the new path is better, update the node
                    if tentativeG < neighbor.g {
                        neighbor.parent = current
                        neighbor.g = tentativeG
                        neighbor.f = tentativeG + state.heuristic(neighbor)
                        state.openSet.insert(neighbor)
                    }
                }
                
                // Artificial slowdown, because otherwise it sooo faaaast
                if state.animationSpeed != 2 {
                    try? await Task.sleep(nanoseconds: UInt64(100_000_000 / state.animationSpeed))
                }
            }
            
            state.isRunning = false
        }
        
        UserDefaults.standard.set(true, forKey: "A*")
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
    AStarPathfindingView()
        .preview()
}
