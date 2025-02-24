//
//  ActionButton.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 06.02.2025.
//

import SwiftUI

struct ActionButton: ButtonStyle {
    let isEdgeToEdge: Bool
    let color: AnyGradient
    
    init(edgeToEdge isEdgeToEdge: Bool = false, color: AnyGradient = Color.accentColor.gradient) {
        self.isEdgeToEdge = isEdgeToEdge
        self.color = color
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: isEdgeToEdge ? .infinity : nil)
            .padding()
            .background(color)
            .clipShape(.rect(cornerRadius: 16))
            .opacity(configuration.isPressed ? 0.5 : 1.0)
    }
}
