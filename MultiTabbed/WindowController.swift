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

        guard let mainWindow = self.window else {
            preconditionFailure("Expected window to be loaded")
        }

        let newWindowController = self.storyboard!.instantiateInitialController() as! WindowController
        let newWindow = newWindowController.window!

        // Add as a new tab right to the current one
        mainWindow.addTabbedWindow(newWindow, ordered: .above)
        newWindow.makeKeyAndOrderFront(self)

        // `newWindowController` is not referenced and will be deallocated at the end of
        // this method, so use 1 shared controller to keep the window in the responder chain.
        newWindow.windowController = self
    }

}
