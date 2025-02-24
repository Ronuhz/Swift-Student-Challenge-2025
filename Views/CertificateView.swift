//
//  CertificateView.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 14.02.2025.
//

import SwiftUI

struct CertificateContentView: View {
    let character: Character
    let width: CGFloat?
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Certificate of Achievement")
                .title()
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            
            Text("This is to certify that")
                .font(.title2)
                .foregroundStyle(.secondary)
            
            Text(character.current.icon)
                .font(.system(size: 72))
            
            Text(character.current.name)
                .font(.title.bold())
                .foregroundStyle(.primary)
            
            Text("has successfully mastered the following pathfinding algorithms")
                .font(.title2)
                .foregroundStyle(.secondary)
            
            VStack(spacing: 16) {
                ForEach(Algorithm.all) { algorithm in
                    Text("\(algorithm.name) (\(algorithm.technicalName))")
                        .font(.title3.bold())
                        .foregroundStyle(Color.accentColor)
                }
            }
            .padding(.vertical)
            
            Text("and is hereby declared a")
                .font(.title2)
                .foregroundStyle(.secondary)
            
            Text("Pathfinding Master")
                .font(.system(size: 42, weight: .bold))
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(width: width)
        .padding(40)
        .background(.background)
        .clipShape(.rect(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(Color.accentColor, lineWidth: 3)
        )
    }
}

struct CertificateView: View {
    @Environment(\.character) private var character
    @Environment(\.audio) private var audio
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            GridBackgroundView()
            
            GeometryReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        CertificateContentView(
                            character: character,
                            width: min(proxy.size.width * 0.9, 900)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                        
                        Spacer()
                        
                        HStack(spacing: 30) {
                            Button("Back") {
                                audio.play(.tap)
                                dismiss()
                            }
                            .buttonStyle(ActionButton(edgeToEdge: true))
                            
                            Button("Save") {
                                audio.play(.tap)
                                saveCertificate()
                            }
                            .buttonStyle(ActionButton(edgeToEdge: true, color: Color.green.gradient))
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: proxy.size.height)
                    .safeAreaPadding(.horizontal)
                }
                .scrollBounceBehavior(.basedOnSize)
            }
        }
    }
    
    @MainActor
    private func saveCertificate() {
        let certificateView = CertificateContentView(
            character: character,
            width: 900
        )
        
        let renderer = ImageRenderer(content: certificateView)
        renderer.scale = 3.0
        
        if let image = renderer.uiImage {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        dismiss()
    }
}

#Preview {
    CertificateView()
        .preview()
}
