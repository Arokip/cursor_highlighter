import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var globalMonitor: GlobalEventMonitor?
    var localMonitor: Any?
    
    // We instantiate the window here so it stays alive as long as the app runs
    let overlayWindow = OverlayWindow()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // 1. Check permissions
        checkPermissions()
        
        // 2. Setup Global Monitor (detects Ctrl when other apps have focus)
        globalMonitor = GlobalEventMonitor(mask: .flagsChanged) { [weak self] event in
            self?.handleFlagsChanged(event: event)
        }
        globalMonitor?.start()
        
        // 3. Setup Local Monitor (detects Ctrl when THIS app has focus)
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            self?.handleFlagsChanged(event: event)
            return event
        }
    }
    
    func handleFlagsChanged(event: NSEvent?) {
        guard let event = event else { return }
        
        // Strict check: Trigger ONLY if Control is the sole modifier key pressed
        if event.modifierFlags.intersection(.deviceIndependentFlagsMask) == .control {
            let mouseLoc = NSEvent.mouseLocation
            DispatchQueue.main.async {
                self.overlayWindow.flash(at: mouseLoc)
            }
        }
    }
    
    func checkPermissions() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)
        
        if accessEnabled {
            print("✅ Accessibility Access Granted")
        } else {
            print("❌ Accessibility Access Denied. Prompting user...")
        }
    }
}
