//
//  NoteView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 05.02.2025.
//

import SwiftUI

struct NoteView: View {
    let title: String
    let systemImage: String
    let foregroundStyle: Color
    
    init(_ title: String, systemImage: String, foregroundStyle: Color = .blue) {
        self.title = title
        self.systemImage = systemImage
        self.foregroundStyle = foregroundStyle
    }
    var body: some View {
        Label(title, systemImage: systemImage)
            .padding(8)
            .background(.ultraThinMaterial.opacity(0.6))
            .clipShape(.rect(cornerRadius: 8))
            .symbolRenderingMode(.multicolor)
            .foregroundStyle(foregroundStyle)
            .font(.headline)
    }
}

#Preview {
    NoteView("Landscape orientation recommended for best experience", systemImage: "rotate.right")
}
