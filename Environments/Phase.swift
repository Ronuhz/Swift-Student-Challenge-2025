//
//  Phase.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class Phase {
    enum PhaseState: Int {
        case welcome
        case characterSelection
        case debriefing
    }
    
    var current = PhaseState.welcome
    
    func next() {
        withAnimation(.spring) {
            self.current = PhaseState(rawValue: self.current.rawValue + 1) ?? .welcome
        }
    }
}
