//  Copyright © 2019 Christian Tietze. All rights reserved. Distributed under the MIT License.

import Cocoa

class TabService: TabDelegate {

    struct ManagedWindow {
        /// Keep the controller around to store a strong reference to it
        let windowController: NSWindowController

        /// Keep the window around to identify instances of this type
        let window: NSWindow

        /// React to window closing, auto-unsubscribing on dealloc
        let closingSubscription: NotificationToken
    }

    fileprivate(set) var managedWindows: [ManagedWindow] = []
    
    /// Returns the main window of the managed window stack.
    /// Falls back the first element if no window is main. Note that this would
    /// likely be an internal inconsistency we gracefully handle here.
    var mainWindow: NSWindow? {
        let mainManagedWindow = managedWindows
            .first { $0.window.isMainWindow }

        // In case we run into the inconsistency, let it crash in debug mode so we
        // can fix our window management setup to prevent this from happening.
        assert(mainManagedWindow != nil || managedWindows.isEmpty)

        return (mainManagedWindow ?? managedWindows.first)
            .map { $0.window }
    }

    init(initialWindowController: WindowController) {
        precondition(addManagedWindow(windowController: initialWindowController) != nil)
    }

    func createTab(newWindowController: WindowController,
                   inWindow window: NSWindow,
                   ordered orderingMode: NSWindow.OrderingMode) {

        guard let newWindow = addManagedWindow(windowController: newWindowController)?.window else { preconditionFailure() }

        window.addTabbedWindow(newWindow, ordered: orderingMode)
        newWindow.makeKeyAndOrderFront(nil)
    }

    private func addManagedWindow(windowController: WindowController) -> ManagedWindow? {

        guard let window = windowController.window else { return nil }

        let subscription = NotificationCenter.default.observe(name: NSWindow.willCloseNotification, object: window) { [unowned self] notification in
            guard let window = notification.object as? NSWindow else { return }
            self.removeManagedWindow(forWindow: window)
        }
        let management = ManagedWindow(
            windowController: windowController,
            window: window,
            closingSubscription: subscription)
        managedWindows.append(management)

        windowController.tabDelegate = self

        return management
    }

    private func removeManagedWindow(forWindow window: NSWindow) {
        managedWindows.removeAll(where: { $0.window === window })
    }

}
