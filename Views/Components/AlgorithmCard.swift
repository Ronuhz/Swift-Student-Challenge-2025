//
//  AlgorithmCard.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 04.02.2025.
//

import SwiftUI

struct AlgorithmCard: View {
    let algorithm: Algorithm
    let isSelected: Bool
    
    @State private var completed: Bool = false
    
    init(for algorithm: Algorithm, isSelected: Bool) {
        self.algorithm = algorithm
        self.isSelected = isSelected
    }
        
    var body: some View {
        HStack(spacing: 24) {
            Text(algorithm.icon)
                .font(.system(size: 64))
                .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                .frame(width: 80)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(algorithm.fullName)
                    .font(.title2.bold())
                    .foregroundStyle(.primary)
                
                Text("*\(algorithm.description)*")
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
        .overlay {
            if completed {
                Image(systemName: "checkmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white, .green)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
            }
        }
        .onAppear {
            completed = UserDefaults.standard.bool(forKey: algorithm.technicalName)
        }
    }
}

#Preview {    
    AlgorithmCard(
        for: Algorithm.example,
        isSelected: true
    )
    .padding()
}
