//  Copyright © 2019 Christian Tietze. All rights reserved. Distributed under the MIT License.

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var tabService: TabService!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let mainStoryboard = NSStoryboard.main else { preconditionFailure() }
        guard let mainController = mainStoryboard.instantiateController(withIdentifier: "MainWindowScene") as? WindowController else { preconditionFailure() }

        mainController.showWindow(nil)
        tabService = TabService(initialWindowController: mainController)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}
