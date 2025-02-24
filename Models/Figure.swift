//
//  Figure.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import Foundation

struct Figure: Identifiable, Codable {
    var id = UUID()
    let name: String
    let icon: String
    let description: String
    let looksFor: Item
    
    static let example = Figure.init(name: "The Algorithm Wizard", icon: "🧙‍♂️", description: "Predicts the future... but only one step at a time.", looksFor: .init(name: "The Scroll of Infinite Knowledge", icon: "📜", descirption: "Contains all pathfinding secrets!"))
}
