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
    
    @discardableResult
    final func checkLocationPermission() -> Bool {
        
        guard let result = self.locationManager?.getAuthorizationStatus() else {
            log.error("[AppDelegate] Error, Could't Get CoreLocation CLAuthorizationStatus")
            return false
        }
        
        // 위치 권한 여부를 확인합니다.
        if result.isPermission { return result.isPermission }
        
        // 현재 위치 권한이 존재하지 않는 경우에는 환경설정을 표시합니다.
        self.locationManager?.openPrivacyLocationServicePref()
        log.info("[AppDelegate] Action, Open Privacy Location Service Preference: \(result.status)")
        
        return false
    }
}

// MARK: - Internal Extension AppDelegate
internal extension AppDelegate {
    
    final func getConfiguration(forResource: String = "Configure", ofType: String = "plist") -> NSDictionary {
        
        guard let fileURLWithPath = Bundle.main.path(forResource: forResource, ofType: ofType) else {
            log.error("[AppDelegate] Error, Could't load Bunlde Resource Path")
            return NSDictionary.init()
        }
        
        let contentsOf = URL(fileURLWithPath: fileURLWithPath)
        return NSDictionary(contentsOf: contentsOf) ?? NSDictionary.init()
    }
    
    final func setupBeaver() {
        
        #if DEBUG
            NSLog("[%@][%@] Initazlie, SwiftyBeaver", AppDelegate.label, AppDelegate.identifier)
        #endif
        
        let consoleDestination = ConsoleDestination()
        consoleDestination.useTerminalColors = true
        setupLogDestination(target: consoleDestination)
        log.addDestination(consoleDestination)
        
        let fileDestination = FileDestination()
        setupLogDestination(target: fileDestination)
        log.addDestination(fileDestination)
        
        let cloudDestination = SBPlatformDestination(appID: "6JvLLY", appSecret: "nlc749Bhy2v0i7zLhbWsuwejebogSdll", encryptionKey: "ocLUmjhjcdkkilgs8Ztarh53L6H4bQay")
        setupLogDestination(target: cloudDestination)
        log.addDestination(cloudDestination)
    }
    
    final func setupStatusItem() {
        
        #if DEBUG
            NSLog("[%@][%@] Initazlie, NSStatusBarButton", AppDelegate.label, AppDelegate.identifier)
        #endif
        
        // A status item length that dynamically adjusts to the width of its contents.
        self.statusItem.length = NSStatusItem.variableLength
        
        // The button displayed in the status bar.
        self.statusItem.button?.image = NSImage(named: "explore-symbol")
        self.statusItem.button?.action = #selector(togglePopover)
        self.statusItem.button?.identifier = .init(rawValue: AppDelegate.identifier)
        
        let contentViewController = SKSystem.shared.loadViewController(name: StoryboardInfo.main.name,
                                                                       withIdentifier: ViewControllerInfo.viewController.name,
                                                                       type: NSViewController.self)
        self.popOver.contentViewController = contentViewController
    }
    
    final func setupLocationManager() {
        
        #if DEBUG
            NSLog("[%@][%@] Initazlie, CLLocationManager", AppDelegate.label, AppDelegate.identifier)
        #endif
        
        // 사용자의 위치 정보를 가져오기 위하여 CoreLocation 권한 설정 작업을 수행합니다.
        self.locationManager = SKCoreLocation(delegate: self)
        
        // 현재 위치 권한 상태를 확인하여 권한이 없는 경우에는 사용자에게 환경설정 창을 보여줍니다.
        checkLocationPermission()
        
        // 위치 정보를 얻어오기 위해서 위치 권한을 요청합니다.
        self.locationManager?.requestAuthorization()
    }
}
#endif
