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
    
    final func setupLogDestination(target: BaseDestination) {
        
        target.format = "$DHH:mm:ss$d $L: $M"
        target.levelString.debug = "🟢 DEBUG"
        target.levelString.info = "🔵 INFO"
        target.levelString.warning = "🟡 WARNING"
        target.levelString.error = "🔴 ERROR"
        
        // 실행중인 애플리케이션이 Debug 상태로 활성화가 되어 진 경우
        let isDebug = SKSystem.shared.getBeingDebugged(pid: self.pid)
        target.minLevel = isDebug ? SwiftyBeaver.Level.debug : SwiftyBeaver.Level.info
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
    
    final func setupBeaver() {
        
        #if DEBUG
            NSLog("[%@][%@] Initazlie, SwiftyBeaver", AppDelegate.label, AppDelegate.identifier)
        #endif
        
        // FileDestination ConsoleDestination 설정합니다.
        let consoleDestination = ConsoleDestination()
        consoleDestination.useTerminalColors = true
        setupLogDestination(target: consoleDestination)
        log.addDestination(consoleDestination)
        
        // SwiftyBeaver FileDestination 설정합니다.
        let fileDestination = FileDestination()
        setupLogDestination(target: fileDestination)
        log.addDestination(fileDestination)
        
        // SwiftyBeaver Cloud 설정 작업을 수행합니다.
        if let configure = ConfigureModel.getAppConfigure() {
            let keys = configure.serviceKeys.swiftyBeaverKey
            let cloudDestination = SBPlatformDestination(appID: keys.appID, appSecret: keys.secret, encryptionKey: keys.encryption)
            setupLogDestination(target: cloudDestination)
            log.addDestination(cloudDestination)
        }
    }
    
    final func setupStatusItem() {
        
        #if DEBUG
            NSLog("[%@][%@] SetUp NSStatusItem", AppDelegate.label, AppDelegate.identifier)
        #endif
        
        // A status item length that dynamically adjusts to the width of its contents.
        self.statusItem.length = NSStatusItem.variableLength
        
        // The button displayed in the status bar.
        self.statusItem.button?.image = NSImage(named: "explore-symbol")
        self.statusItem.button?.title = "오늘도맑음"
        self.statusItem.button?.action = #selector(togglePopover)
        self.statusItem.button?.identifier = .init(rawValue: AppDelegate.identifier)
        
        let withIdentifier = ViewControllerInfo.viewController.name
        let contentViewController = SKCocoa.shared.loadViewController(name: StoryboardInfo.main.name,
                                                                       withIdentifier: withIdentifier,
                                                                       type: NSViewController.self)
        self.popOver.contentViewController = contentViewController
    }
    
    final func setStatusBarButton(image: NSImage?, colors: NSColor..., title: String, toolTip: String) {
        
        #if DEBUG
            NSLog("[%@][%@] SetUp NSStatusBarButton", AppDelegate.label, AppDelegate.identifier)
        #endif
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let configuration = NSImage.SymbolConfiguration(paletteColors: colors)
            self.statusItem.button?.image = image?.withSymbolConfiguration(configuration)
            self.statusItem.button?.title = title
            self.statusItem.button?.toolTip = toolTip
        }
    }
}
#endif
