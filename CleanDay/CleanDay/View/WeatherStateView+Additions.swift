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

// MARK: - Private Extension WeatherStateView
private extension WeatherStateView {
    
    final func convertWeekOfDayLanguage(weekOfDay: WeekOfDay) -> String {
        
        // WeekOfDay을 기반으로 요일을 한글로 변환합니다.
        switch weekOfDay {
        case .monday:       return "월요일"
        case .tuesday:      return "화요일"
        case .wednesday:    return "수요일"
        case .thursday:     return "목요일"
        case .friday:       return "금요일"
        case .saturday:     return "토요일"
        case .sunday:       return "일요일"
        }
    }
}

// MARK: - Public Extension WeatherStateView
public extension WeatherStateView {
    
    final func setup(weekOfDay: WeekOfDay, temperature: Double, systemSymbolName: String) {
        
        #if DEBUG
            NSLog("[%@][%@] Initalize, WeatherStateView", Self.label, Self.identifier)
        #endif
        
        // NSTextField를 설정합니다.
        self.dayOfWeakLabel.stringValue = convertWeekOfDayLanguage(weekOfDay: weekOfDay)
        self.temperatureLabel.stringValue = String(format: "%.1f°", temperature)
        
        // NSImageView를 설정합니다.
        let configuration = NSImage.SymbolConfiguration.preferringMulticolor()
        let image = NSImage(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
        self.weatherStateImageView.image = image?.withSymbolConfiguration(configuration)
    }
}
#endif
