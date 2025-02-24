//
//  Node.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 15.02.2025.
//

import Foundation

final class Node: Hashable, Identifiable, Equatable {
    let id = UUID()
    let x: Int
    let y: Int
    
//    A*, Dijkstra
    var f: Double = Double.infinity  // Total cost (g + h)
    
//    A*
    var g: Double = Double.infinity  // Cost from start to current node
    
//    A*, Dijkstra, DFS
    weak var parent: Node?
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
//    MARK: - Conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
