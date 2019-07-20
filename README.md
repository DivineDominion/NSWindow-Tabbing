# Programmatic NSWindow Tabbing

![Swift 5.0](https://img.shields.io/badge/Swift-5.0-blue.svg?style=flat)
![License](https://img.shields.io/github/license/DivineDominion/MultiTabbed.svg?style=flat)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg?style=flat)

Demonstrating how to implement programmatic creation of tabs in `NSWindow`s without the use of `NSDocument`.

- Checkout the `shared-window-controller` tag to see how to re-use a single `NSWindowController` for all tabs as [per my blog post](https://christiantietze.de/posts/2019/07/nswindow-tabbing-single-nswindowcontroller/). Don't use this in production, though.
- Checkout the `multiple-window-controllers` tag or the current `master` branch to see how to manage `NSWindowController`s for your tabs.

The underlying difficulty people on StackOverflow etc. are experiencing is that creating your `NSWindowController` from a storyboard will initialize the window contents, but you need to keep the window controller itself alive to respond to main menu actions. Otherwise, the "+" (add tab) button will appear broken for all but the initial tab.

## License

Copyright (c) 2019 Christian Tietze. Distributed under the MIT License.
