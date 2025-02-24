//
//  EnvironmentValuesExtensions.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 20.02.2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var phase = Phase()
    @Entry var audio = Audio()
    @Entry var character = Character()
}
