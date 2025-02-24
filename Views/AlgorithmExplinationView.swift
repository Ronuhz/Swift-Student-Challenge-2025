//
//  AlgorithmExplinationView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 09.02.2025.
//

import SwiftUI

struct AlgorithmExplinationView: View {
    @Environment(\.character) private var character
    @Environment(\.colorScheme) private var colorScheme
    @State private var revealDetails = false
    
    let algorithm: Algorithm
    
    init(_ algorithm: Algorithm) {
        self.algorithm = algorithm
    }
    
    private var algorithmExplanation: [String] {
        algorithm.getExplanation(characterName: character.current.name, goalName: character.current.looksFor.name)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Character and goal Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 12) {
                        Text(character.current.icon)
                            .font(.system(size: 48))
                        
                        VStack(alignment: .leading) {
                            Text(character.current.name)
                                .font(.title3.bold())
                            
                            Text("Looking for \(character.current.looksFor.icon) \(character.current.looksFor.name.lowercased())")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 16))
                }
                
                // Algorithm explanation section
                VStack(alignment: .leading, spacing: 16) {
                    Text(algorithm.name)
                        .font(.title.bold())
                    + Text(" (\(algorithm.technicalName))")
                        .foregroundStyle(.secondary)
                        .font(.title2)
                    
                    DisclosureGroup("Technical Details", isExpanded: $revealDetails) {
                        Text(algorithm.technicalDescription)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Text("How it works:")
                        .font(.title2)
                    
                    
                    ForEach(algorithmExplanation.indices, id: \.self) { index in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                                .frame(width: 24, height: 24)
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                            
                            Text(algorithmExplanation[index])
                                .font(.body)
                        }
                    }
                    
                    Text("Color Legend:")
                        .font(.title2)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ColorLegendItem(color: colorScheme == .light ? .white : .black, label: "Unexplored Area")
                        ColorLegendItem(color: colorScheme == .light ? .black : .white, label: "Wall")
                        ColorLegendItem(color: .green, label: "Start Position")
                        ColorLegendItem(color: .red, label: "Goal")
                        ColorLegendItem(color: .yellow, label: "Found Path")
                        ColorLegendItem(color: .blue.opacity(0.5), label: "Currently Exploring")
                        ColorLegendItem(color: .gray.opacity(0.5), label: "Already Explored")
                    }
                }
            }
            .safeAreaPadding(.horizontal)
        }
        .background(.thinMaterial)
    }
}

struct ColorLegendItem: View {
    let color: Color
    let label: String
    
    var body: some View {
        HStack(spacing: 12) {
            Rectangle()
                .fill(color)
                .frame(width: 24, height: 24)
                .clipShape(.rect(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                )
            
            Text(label)
                .font(.body)
        }
    }
}

#Preview {
    AlgorithmExplinationView(Algorithm.example)
    .preview()
}
