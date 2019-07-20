//  Copyright © 2019 Christian Tietze. All rights reserved. Distributed under the MIT License.

import Cocoa

var count = 0

protocol TabDelegate: class {
    func createTab(newWindowController: WindowController,
                   inWindow window: NSWindow,
                   ordered orderingMode: NSWindow.OrderingMode)
}

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        count += 1
        self.window!.title = "Window #\(count)"
    }

    weak var tabDelegate: TabDelegate?

    override func newWindowForTab(_ sender: Any?) {

        guard let window = self.window else { preconditionFailure("Expected window to be loaded") }
        guard let tabDelegate = self.tabDelegate else { return }

        let newWindowController = self.storyboard!.instantiateInitialController() as! WindowController

        tabDelegate.createTab(newWindowController: newWindowController,
                              inWindow: window,
                              ordered: .above)

        inspectWindowHierarchy()
    }

    func inspectWindowHierarchy() {
        let rootWindow = self.window!
        print("Root window", rootWindow, rootWindow.title, "has tabs:")
        rootWindow.tabbedWindows?.forEach { window in
            print("- ", window, window.title, "isKey =", window.isKeyWindow, ", isMain =", window.isMainWindow, " at ", window.frame)
        }
    }
}
