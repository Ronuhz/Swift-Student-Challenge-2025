import SwiftUI

struct ContentView: View {
    @Environment(\.phase) private var phase
    
    var body: some View {
        ZStack {
            GridBackgroundView()
            
            switch phase.current {
            case .welcome:
                WelcomeView()
            case .characterSelection:
                CharacterSelectionView()
            case .debriefing:
                DebriefingView()
            }
        }
    }
}

#Preview {
    ContentView()
        .preview()
}
