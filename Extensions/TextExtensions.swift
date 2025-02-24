//
//  TextExtensions.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 05.02.2025.
//

import SwiftUI

//MARK: - Text
extension Text {
    func title() -> some View {
        self.modifier(TitleModifier())
    }
    
    func subtitle() -> some View {
        self.modifier(SubtitleModifier())
    }
}

//MARK: - Text.Layout
extension Text.Layout {
    var flattenedRuns: some RandomAccessCollection<Text.Layout.Run> {
        self.flatMap { line in
            line
        }
    }

    var flattenedRunSlices: some RandomAccessCollection<Text.Layout.RunSlice> {
        flattenedRuns.flatMap(\.self)
    }
}
