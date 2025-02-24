//
//  FigureCard.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct FigureCard: View {
    let figure: Figure
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 24) {
            Text(figure.icon)
                .font(.system(size: 64))
                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                .frame(width: 80)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(figure.name)
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                
                Text("*\(figure.description)*")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 130, maxHeight: .infinity)
        .padding()
        .background(
            Group {
                if isSelected {
                    Color.accentColor.opacity(0.2)
                } else {
                    Color(.systemBackground).opacity(0.5)
                }
            }
        )
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? Color.accentColor : Color(.separator), lineWidth: isSelected ? 3 : 0.5)
        )
        .shadow(color: .primary.opacity(0.1), radius: 8, y: 4)
    }
}

#Preview {
    @Previewable @State var isSelected: Bool = false
    Button {
        isSelected.toggle()
    } label: {
        FigureCard(figure: .example, isSelected: isSelected)
    }
    .padding()
    .buttonStyle(.plain)
}
