//  Copyright © 2019 Christian Tietze. All rights reserved. Distributed under the MIT License.

import Cocoa

var count = 0

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        count += 1
        self.window!.title = "Window #\(count)"
    }

    override func newWindowForTab(_ sender: Any?) {

        guard let mainKeyWindow = self.window else {
            preconditionFailure("Expected window to be loaded")
        }

        let newWindowController = self.storyboard!.instantiateInitialController() as! WindowController
        let newWindow = newWindowController.window!

        // Add as a new tab right to the current one
        mainKeyWindow.addTabbedWindow(newWindow, ordered: .above)
        newWindow.delegate = self // Set delegate first to notify about key window changes
        newWindow.makeKeyAndOrderFront(self)

        // `newWindowController` is not referenced and will be deallocated at the end of
        // this method, so use 1 shared controller to keep the window in the responder chain.
        newWindow.windowController = self

        inspectWindowHierarchy()
    }

    func windowDidBecomeKey(_ notification: Notification) {
        guard let window = notification.object as? NSWindow else { return }
        guard window != self.window else { return }
        let oldFrame = self.window?.frame
        self.window = window
        inspectWindowHierarchy()
        if let oldFrame = oldFrame {
            window.setFrame(oldFrame, display: true)
        }
    }

    func inspectWindowHierarchy() {
        let rootWindow = self.window!
        print("Root window", rootWindow, rootWindow.title, "has tabs:")
        rootWindow.tabbedWindows?.forEach { window in
            print("- ", window, window.title, "isKey =", window.isKeyWindow, ", isMain =", window.isMainWindow, " at ", window.frame)
        }
    }
}
