//  Copyright © 2019 Christian Tietze. All rights reserved. Distributed under the MIT License.

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var tabService: TabService!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        replaceTabService()
    }

    /// Fallback for the menu bar action when all windows are closed.
    @IBAction func newWindowForTab(_ sender: Any?) {

        // Not supposed to be called while another window is visible
        precondition(tabService.managedWindows.isEmpty)
        replaceTabService()
    }

    private func replaceTabService() {
        let windowController = WindowController.create()
        windowController.showWindow(self)
        tabService = TabService(initialWindowController: windowController)
    }

}
