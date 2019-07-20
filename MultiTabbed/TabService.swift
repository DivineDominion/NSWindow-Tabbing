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
        guard let index = managedWindows.firstIndex(where: { $0.window === window }) else { return }
        managedWindows.remove(at: index)
    }

}
