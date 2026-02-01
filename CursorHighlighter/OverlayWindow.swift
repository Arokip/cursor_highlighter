import Cocoa
import SwiftUI

class OverlayWindow: NSWindow {
    private var closeItem: DispatchWorkItem?

    init() {
        super.init(
            contentRect: .zero,
            styleMask: [.borderless], // No title bar
            backing: .buffered,
            defer: false
        )
        
        self.isOpaque = false
        self.backgroundColor = .clear
        self.level = .floating
        self.ignoresMouseEvents = true
        
        // FIX 1: Disable shadow to prevent visual offset
        self.hasShadow = false
        
        // FIX 2: Ensure window isn't destroyed when closed
        self.isReleasedWhenClosed = false
        
        self.collectionBehavior = [.canJoinAllSpaces, .transient]
    }
    
    func flash(at point: NSPoint) {
        closeItem?.cancel()
        
        // Define the exact size of the window square
        let windowSize: CGFloat = 220
        
        // FIX 3: Precise centering math
        // We calculate the bottom-left origin of the window so its center hits the mouse point
        let newOrigin = NSPoint(
            x: point.x - (windowSize / 2),
            y: point.y - (windowSize / 2)
        )
        
        self.setFrame(NSRect(origin: newOrigin, size: CGSize(width: windowSize, height: windowSize)), display: true)
        
        // Load the view
        self.contentView = NSHostingView(rootView: CursorEffectView())
        
        self.makeKeyAndOrderFront(nil)
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.close()
        }
        
        self.closeItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
}
