//
//  AlgorithmPlaygroundView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 05.02.2025.
//

import SwiftUI

struct AlgorithmPlaygroundView: View {
    let algorithm: Algorithm
    
    @Environment(\.character) private var character
    @Environment(\.phase) private var phase
        
    var body: some View {
        GeometryReader { proxy in
            let isLandscape = proxy.size.width > proxy.size.height
            
            Group {
                if isLandscape {
                    HStack(spacing: 0) {
                        AlgorithmExplinationView(algorithm)
                            .frame(width: proxy.size.width * 0.4)
                        
                        switch algorithm.type {
                        case .dfs:
                            DFSPathfindingView()
                        case .dijkstra:
                            DijkstraPathfindingView()
                        case .aStar:
                            AStarPathfindingView()
                        }
                    }
                } else {
                    VStack(spacing: 0) {
                        AlgorithmExplinationView(algorithm)
                            .frame(height: proxy.size.height * 0.4)
                        
                        switch algorithm.type {
                        case .dfs:
                            DFSPathfindingView()
                        case .dijkstra:
                            DijkstraPathfindingView()
                        case .aStar:
                            AStarPathfindingView()
                        }
                    }
                }
            }
            .background(.background)
        }
    }
}

#Preview {
    AlgorithmPlaygroundView(algorithm: .example)
    .preview()
}
