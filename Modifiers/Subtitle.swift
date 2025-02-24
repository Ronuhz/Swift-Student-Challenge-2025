//
//  Subtitle.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct SubtitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundStyle(.secondary)
            .padding(.bottom, 16)
    }
}
