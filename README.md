# CursorHighlighter

A macOS menu bar app that shows an animated circle around your mouse cursor whenever you press the **Control** key. Useful for presentations, screen recordings, or anytime you want to make the cursor easier to spot.

## What it does

- **Trigger:** Press the Control key (⌃) alone—no other modifier keys.
- **Effect:** A teal circle appears at the cursor position, animates outward, and fades out over about half a second.
- **Works globally:** The circle appears no matter which app is in focus (browser, terminal, IDE, etc.).

## Requirements

- macOS
- Xcode (to build)
- **Accessibility permission:** The app needs “Accessibility” access to monitor keyboard events system-wide. macOS will prompt you the first time you run it; enable it in **System Settings → Privacy & Security → Accessibility**.

## Building and running

1. Open `CursorHighlighter.xcodeproj` in Xcode.
2. Select your Mac as the run destination and press **Run** (⌘R).
3. Grant Accessibility access when prompted.
4. Press **Control** anywhere on your screen to see the circle at the cursor.

## How it works

- **GlobalEventMonitor** and a local event monitor listen for `flagsChanged` (modifier key) events.
- When only Control is pressed, the app gets the current mouse location and shows a small borderless overlay window there.
- **OverlayWindow** is a transparent, click-through, floating window that stays on top and is visible across all spaces.
- **CursorEffectView** draws the circle and runs a short scale-and-fade animation; the overlay then closes automatically.

## License

Use and modify as you like.
