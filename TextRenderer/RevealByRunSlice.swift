//
//  RevealByRunSlice.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 13.02.2025.
//

import SwiftUI

struct RevealByRunSliceEffectRenderer: TextRenderer, Animatable {
    var elapsedTime: TimeInterval
    var elementDuration: TimeInterval
    var totalDuration: TimeInterval
    
    var spring = Spring.smooth
    
    var animatableData: Double {
        get { elapsedTime }
        set { elapsedTime = newValue }
    }
    
    init(elapsedTime: TimeInterval, elementDuration: TimeInterval = 0.4, totalDuration: TimeInterval) {
        self.elapsedTime = min(elapsedTime, totalDuration)
        self.elementDuration = min(elementDuration, totalDuration)
        self.totalDuration = totalDuration
    }
    
    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        let delayPerSlice = delay(count: layout.flattenedRunSlices.count)
        for (index, slice) in layout.flattenedRunSlices.enumerated() {
            let sliceTime = max(0, min(elapsedTime - (TimeInterval(index) * delayPerSlice), elementDuration))
            
//            otherwise multiple lines of text, gets squashed together
            var sliceContext = context
            
            draw(slice, at: sliceTime, in: &sliceContext)
        }
    }
    
    func draw(_ slice: Text.Layout.RunSlice, at time: TimeInterval, in context: inout GraphicsContext) {
        let progress = time / elementDuration
        let opacity = UnitCurve.easeIn.value(at: 10 * progress)
        let blurRadius = (slice.typographicBounds.rect.height / 16) * UnitCurve.easeIn.value(at: 1 - progress)
        let translationY = spring.value(
            fromValue: -slice.typographicBounds.descent,
            toValue: 0,
            initialVelocity: 0,
            time: time)
        
        context.translateBy(x: 0, y: translationY)
        context.addFilter(.blur(radius: blurRadius))
        context.opacity = opacity
        context.draw(slice, options: .disablesSubpixelQuantization)
    }
    
    func delay(count: Int) -> TimeInterval {
        let countDouble = Double(count)
        let remainingTime = totalDuration - countDouble * elementDuration
        return max(remainingTime / (countDouble + 1), (totalDuration - elementDuration) / countDouble)
    }
}

struct RevealByRunSlice: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        let duration = 2.0

        let elapsedTime = phase.isIdentity ? duration : 0
        let renderer = RevealByRunSliceEffectRenderer(elapsedTime: elapsedTime, totalDuration: duration)
        
        return content.transaction { transaction in
            if !transaction.disablesAnimations {
                transaction.animation = .bouncy(duration: duration)
            }
        } body: { view in
            view.textRenderer(renderer)
        }
    }
}
