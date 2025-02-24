//
//  Character.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import Foundation
import Observation

@Observable
final class Character {
    var current: Figure
    
//    All possible characters with the item they are looking for.
    static let all = [Figure]([
        .init(name: "Bob the Clueless Tourist", icon: "🏃", description: "Knows every fast-food menu by heart but gets lost in his own house.", looksFor: .init(name: "A burger stand", icon: "🍔", descirption: "Because he saw a sign... 3 miles ago.")),
        .init(name: "Squeaky the Maze Mouse", icon: "🐭", description: "Trained in the fine art of cheese seeking. Gets nervous around cats.", looksFor: .init(name: "The ultimate cheese stash", icon: "🧀", descirption: "Rumored to be at the maze’s center!")),
        .init(name: "Speedy the RC Car", icon: "🚗", description: "Too fast, too furious... but still needs directions.", looksFor: .init(name: "A fresh battery", icon: "🔋", descirption: "Because the current one is at 5%... panic mode activated.")),
        .init(name: "A*Bot 3000", icon: "🤖", description: "Uses cutting-edge AI... but still loses Wi-Fi sometimes.", looksFor: .init(name: "A stable Wi-Fi signal", icon: "🛜", descirption: "Error 404: Connection not found.")),
        .init(name: "The Algorithm Wizard", icon: "🧙‍♂️", description: "Predicts the future... but only one step at a time.", looksFor: .init(name: "The Scroll of Infinite Knowledge", icon: "📜", descirption: "Contains all pathfinding secrets!")),
        .init(name: "Lost Rex", icon: "🦖", description: "A dinosaur with a BIG problem, he wasn't supposed to be in this timeline.", looksFor: .init(name: "A time portal", icon: "⏳", descirption: "Gotta get back before humans freak out!"))
    ])

    init() {
        self.current = Character.all.first!
        self.load()
    }
    
//    Loads the selected character from UserDefaults or sets a default one if no character was available in UserDefaults.
    private func load() {
        let defaultCharacter: Figure = Character.all.first!
        
        if let savedCharacter = UserDefaults.standard.object(forKey: "character") as? Data, let loadedCharacter = try? JSONDecoder().decode(Figure.self, from: savedCharacter) {
            self.current = loadedCharacter
        } else {
            self.current = defaultCharacter
        }
    }
    
//    Encodes and saves a character to UserDefault, then loads it.
    func save(_ character: Figure) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(character) {
            UserDefaults.standard.set(encoded, forKey: "character")
        }
        
        load()
    }
}
