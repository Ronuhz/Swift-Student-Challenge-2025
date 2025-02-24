//
//  DijkstraPathfindingViewExtensions.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 12.02.2025.
//

import Foundation

extension DijkstraPathfindingView {
   @Observable
    final class PathfindingState {
        var openSet: Set<Node> = []
        var closedSet: Set<Node> = []
        var path: [Node] = []
        var walls: Set<Node> = []
        var isRunning = false

        let gridSize: Int
        let nodes: [[Node]]
        var startNode: Node
        var endNode: Node
        
        var animationSpeed: Double = 1.5

        init(gridSize: Int, startX: Int, startY: Int, endX: Int, endY: Int) {
            self.gridSize = gridSize
            nodes = (0..<gridSize).map { y in
                (0..<gridSize).map { x in
                    Node(x: x, y: y)
                }
            }
            startNode = nodes[startY][startX]
            endNode = nodes[endY][endX]
        }
    }

}
