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

import SystemKit

// MARK: - Private Extension ViewController
private extension ViewController {
    
    final func setStatusBarWithDust(grade: String, value: String, date: String, type: DustModel.DustType) {
        
        var result = StatusBarResult()
                
        switch grade {
        case "1":
            result.image = NSImage(systemSymbolName: "aqi.low", accessibilityDescription: nil)
            result.imageColor = NSColor.systemBlue
            result.title = String(format: "%@ 좋음", type.rawValue)
        case "2":
            result.image = NSImage(systemSymbolName: "aqi.medium", accessibilityDescription: nil)
            result.imageColor = NSColor.systemGreen
            result.title = String(format: "%@ 보통", type.rawValue)
        case "3":
            result.image = NSImage(systemSymbolName: "aqi.high", accessibilityDescription: nil)
            result.imageColor = NSColor.systemBrown
            result.title = String(format: "%@ 나쁨", type.rawValue)
        case "4":
            result.image = NSImage(systemSymbolName: "aqi.high", accessibilityDescription: nil)
            result.imageColor = NSColor.systemRed
            result.title = String(format: "%@ 매우나쁨", type.rawValue)
        default:
            log.error("[ViewController] Error, Invaild Air Quality Grdage")
            return
        }
        
        result.tooltip = String(format: "[%@] %@ ㎍/㎥", date, value)
        
        // 미세먼지 관련 정보를 취합하여 NSStatusBarButton을 설정합니다.
        self.appDelegate?.setStatusBarButton(image: result.image, colors: result.imageColor,
                                             title: result.title, toolTip: result.tooltip)
    }
}

// MARK: - Internal Extension ViewController
internal extension ViewController {
    
    final func createWeekOfDayWeatherState(stackView: NSStackView) {
        
        #if DEBUG
            NSLog("[%@][%@] Action, Create WeekOfDay WeatherStateView", Self.label, Self.identifier)
        #endif
        
        for weekOfDay in WeatherStateView.WeekOfDay.allCases {
            
            DispatchQueue.main.async {
                
                // WeatherStateView CustomView를 생성합니다.
                guard let view = SKCocoa.shared.loadCustomView(name: StoryboardInfo.weatherStateView.name,
                                                               type: WeatherStateView.self) else {
                    log.error("[ViewController] Error, Could't Create WeekOfDay WeatherStateView")
                    return
                }
                
                // NSStackView에 생성 된 WeatherStateView를 추가합니다.
                stackView.addArrangedSubview(view)
                
                // TopAnchor 및 BottomAnchor에 AutoLayout을 설정합니다.
                view.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
                
                view.setup(weekOfDay: weekOfDay, temperature: 26.5, systemSymbolName: "cloud.sun.fill")
            }
        }
    }
    
    final func setupStatusBarWithWeather() {
        
    }
    
    final func setupStatusBarWithDust(response: DustModel.Response, type: DustModel.DustType) {
        
        #if DEBUG
            NSLog("[%@][%@] Action, SetUp Dust NSStatusBar", Self.label, Self.identifier)
        #endif
        
        guard let first = response.response.body.items.first else { return }
        
        switch type {
        case .fineDust:
            setStatusBarWithDust(grade: first.pm10Grade, value: first.pm10Value,
                                 date: first.dataTime, type: type)
        case .ultrafineDust:
            setStatusBarWithDust(grade: first.pm25Grade, value: first.pm25Value,
                                 date: first.dataTime, type: type)
        }
    }
    
    final func setupDustStateView(response: DustModel.Response, station: String) {
        
        #if DEBUG
            NSLog("[%@][%@] Action, SetUp Dust StateView", Self.label, Self.identifier)
        #endif
        
        guard let recent = response.response.body.items.first else { return }
        
        let toolTip = String(format: "⏱️ 측정시간: %@", recent.dataTime)
        
        self.dustStationLabel.stringValue = station
        
        self.dustPM10ValueLabel.toolTip = toolTip
        self.dustPM10ValueLabel.stringValue = String(format: "%@ %@ ㎍/㎥",
                                                     DustModel.DustType.fineDust.name, recent.pm10Value)
        
        self.dustPM25ValueLabel.toolTip = toolTip
        self.dustPM25ValueLabel.stringValue = String(format: "%@ %@ ㎍/㎥",
                                                     DustModel.DustType.ultrafineDust.name, recent.pm25Value)
    }
}
#endif
