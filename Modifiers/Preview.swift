//
//  Preview.swift.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct Preview: ViewModifier {
    @State private var audio = Audio()
    @State private var character = Character()
    @State private var phase = Phase()
    
    func body(content: Content) -> some View {
        content
            .environment(\.audio, audio)
            .environment(\.character, character)
            .environment(\.phase, phase)
            .fontDesign(.monospaced)
    }
}
