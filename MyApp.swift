import SwiftUI

@main
struct MyApp: App {
    @State private var audio = Audio()
    @State private var character = Character()
    @State private var phase = Phase()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.audio, audio)
                .environment(\.character, character)
                .environment(\.phase, phase)
                .fontDesign(.monospaced)
        }
    }
}
