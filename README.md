# Programmatic NSWindow Tabbing

![Swift 5.3](https://img.shields.io/badge/Swift-5.3-blue.svg?style=flat)
![License](https://img.shields.io/github/license/DivineDominion/NSWindow-Tabbing.svg?style=flat)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey.svg?style=flat)

Demonstrating how to implement programmatic creation of tabs in `NSWindow`s without the use of `NSDocument`.

- Checkout the `shared-window-controller` tag to see how to re-use a single `NSWindowController` for all tabs as [per my experimental blog post](https://christiantietze.de/posts/2019/07/nswindow-tabbing-single-nswindowcontroller/). Don't use this in production, though.
- Checkout the `multiple-window-controllers` tag or the current `master` branch to see how to manage `NSWindowController`s for your tabs. I [wrote about this production-ready approach, too](https://christiantietze.de/posts/2019/07/nswindow-tabbing-multiple-nswindowcontroller/).

The underlying difficulty people on StackOverflow etc. are experiencing is that creating your `NSWindowController` from a storyboard will initialize the window contents, but you need to keep the window controller itself alive to respond to main menu actions. Otherwise, the "+" (add tab) button will appear broken for all but the initial tab.

## License

Copyright (c) 2019--2021 Christian Tietze. Distributed under the MIT License.
