//
//  ViewExtensions.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 05.02.2025.
//

import SwiftUI

//MARK: - View
extension View {
    func preview() -> some View {
        self
            .modifier(Preview())
            .fontDesign(.monospaced)
    }
}
