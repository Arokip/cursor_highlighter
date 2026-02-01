import SwiftUI

@main
struct CursorHighlighterApp: App {
    // This line connects your new file to the app lifecycle
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
