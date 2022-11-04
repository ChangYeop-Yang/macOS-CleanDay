/*
 * Copyright (c) 2022 ChangYeop-Yang. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#if os(macOS)
import Cocoa
import Foundation

import SystemKit
import SwiftyBeaver

// MARK: - Private Extension AppDelegate
private extension AppDelegate {
    
    static func loadViewController() -> ViewController {
        
        let storyboard = NSStoryboard(name: StoryboardInfo.main.name, bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(stringLiteral: ViewControllerInfo.viewController.name)
        
        guard let target = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
            fatalError("[AppDelegate] Error, Could't Load NSViewController")
        }
        
        return target
    }
    
    @objc final func togglePopover(_ sender: NSStatusBarButton) {
       
        switch self.popOver.isShown {
        // NSPopover 화면에 표시되지 않은 경우에는 NSPopover 창을 표시합니다.
        case false:
            log.debug("[AppDelegate] Action, Show NSPopover Window")
            self.popOver.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
            
        // NSPopover 화면에 표시되지 된 경우에는 NSPopover 창을 종료합니다.
        case true:
            log.debug("[AppDelegate] Action, Close NSPopover Window")
            self.popOver.performClose(sender)
        }
    }
}

// MARK: - Internal Extension AppDelegate
internal extension AppDelegate {
    
    final func setupBeaver(pid: pid_t = getpid()) {
        
        let console = ConsoleDestination()
        let file = FileDestination()
        
        console.format = "$DHH:mm:ss$d $L: $M"
        
        let result = SKSystem.shared.getBeingDebugged(pid: pid)
        console.minLevel = result ? SwiftyBeaver.Level.debug : SwiftyBeaver.Level.info
        
        console.useTerminalColors = true
        console.levelString.debug = "🟢 DEBUG"
        console.levelString.info = "🔵 INFO"
        console.levelString.warning = "🟡 WARNING"
        console.levelString.error = "🔴 ERROR"
        
        log.addDestination(console)
        log.addDestination(file)
    }
    
    final func setupStatusItem() {
                
        let statusButton = self.statusItem.button
        
        statusButton?.image = NSImage(systemSymbolName: "timelapse", accessibilityDescription: nil)
        statusButton?.image?.isTemplate = true
        statusButton?.imageScaling = .scaleProportionallyUpOrDown
        
        statusButton?.action = #selector(togglePopover)
        statusButton?.identifier = NSUserInterfaceItemIdentifier(AppDelegate.identifier)
        
        self.popOver.contentViewController = AppDelegate.loadViewController()
    }
    
    final func changeStatusItemSystemImage(systemSymbolName: String) {
        
        DispatchQueue.main.async { [unowned self] in
            
            log.info("[AppDelegate] Action, Change NSStatusBarButton Image")
            
            let statusButton = self.statusItem.button
            statusButton?.image = NSImage(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
            statusButton?.image?.isTemplate = true
        }
    }
}
#endif
