//
//  GridBackgroundView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct GridBackgroundView: View {
    let gridSpacing: CGFloat = 40
    let lineWidth: CGFloat = 1
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                // Vertical lines
                for x in stride(from: 0, through: geometry.size.width, by: gridSpacing) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                }
                
                // Horizontal lines
                for y in stride(from: 0, through: geometry.size.height, by: gridSpacing) {
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }
            }
            .stroke(Color.accentColor.opacity(0.2), lineWidth: lineWidth)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GridBackgroundView()
}
