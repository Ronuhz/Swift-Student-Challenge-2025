//
//  File.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 09.02.2025.
//

import Foundation

struct Algorithm: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let technicalName: String
    let icon: String
    let description: String
    let technicalDescription: String
    let type: AlgorithmType
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static let all = [
        Algorithm(
            name: "The Explorer",
            technicalName: "DFS",
            icon: "🏃",
            description: "Bravely charges into every path, sometimes the wrong ones too! Loves adventure, but might take the long way around.",
            technicalDescription: "Depth-First Search (DFS) explores as far as possible along one path before backtracking. It doesn't guarantee the shortest path but covers all possibilities.",
            type: .dfs
        ),
        Algorithm(
            name: "The Pathfinder",
            technicalName: "Dijkstra",
            icon: "🧭",
            description: "Meticulous and precise! Calculates every route to guarantee the shortest way forward, no wasted steps!",
            technicalDescription: "Dijkstra’s Algorithm systematically explores all paths, always expanding from the closest known point. It guarantees the shortest path but can be slow in large areas.",
            type: .dijkstra
        ),
        Algorithm(
            name: "The Brilliant Guide",
            technicalName: "A*",
            icon: "⭐️",
            description: "A genius navigator! Balances speed and strategy to find the best path with minimal effort.",
            technicalDescription: "A* Search combines the best of both worlds: known distances (Dijkstra) and a smart guess toward the goal (heuristic). It’s efficient and usually finds the best route quickly.",
            type: .aStar
        )
    ]
    static let example = Algorithm.init(
        name: "The Brilliant Guide",
        technicalName: "A*",
        icon: "⭐️",
        description: "A genius navigator! Balances speed and strategy to find the best path with minimal effort.",
        technicalDescription: "A* Search combines the best of both worlds: known distances (Dijkstra) and a smart guess toward the goal (heuristic). It’s efficient and usually finds the best route quickly.",
        type: .aStar
    )
    
    var fullName: String {
        "\(name) (\(technicalName))"
    }
    
    func getExplanation(characterName: String, goalName: String) -> [String] {
        switch type {
        case .dfs:
            return [
                "Imagine \(characterName) as a bold explorer who dives deep into one path at a time.",
                "They follow a single direction until they hit a dead end.",
                "Then, they backtrack to the last fork and try a new route.",
                "They'll eventually find \(goalName.lowercased()), but it might not be the fastest way!"
            ]
        case .dijkstra:
            return [
                "\(characterName) turns into a careful cartographer, measuring every step.",
                "They explore all directions at once, always choosing the closest unexplored spot.",
                "By tracking distances everywhere, they guarantee the shortest route to \(goalName.lowercased()).",
                "It's like watching ripples spread from a pebble."
            ]
        case .aStar:
            return [
                "\(characterName) becomes a savvy navigator, balancing distance traveled with smart guesses.",
                "They favor paths that head toward \(goalName.lowercased()) while keeping track of progress.",
                "This mix of strategy and speed finds a near optimal route fast.",
                "Think of it as a compass that not only points to the goal but also scouts the terrain ahead!"
            ]
        }
    }
    
    enum AlgorithmType {
        case dfs, dijkstra, aStar
    }
}
