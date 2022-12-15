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

public class WeatherStateView: NSView, SKClass {
    
    // MARK: - Enum
    public enum WeekOfDay: String, CaseIterable {
        
        /// Indicates Monday.
        case monday = "Monday"
        
        /// Indicates Tuesday.
        case tuesday = "Tuesday"
        
        /// Indicates Wednesday.
        case wednesday = "Wednesday"
        
        /// Indicates Thursday.
        case thursday = "thursday"
        
        /// Indicates Friday.
        case friday = "Friday"
        
        /// Indicates Saturday.
        case saturday = "Saturday"
        
        /// Indicates Sunday.
        case sunday = "sunday"
    }
    
    // MARK: - Object Properties
    public static var label: String = "com.ChangYeopYang.CleanDay.WeatherStateView"
    public static var identifier: String = "B08EB69E-E835-406D-B3AF-5604AE94D012"
        
    // MARK: - Outlet Properties
    @IBOutlet internal weak var dayOfWeakLabel: NSTextField!
    @IBOutlet internal weak var temperatureLabel: NSTextField!
    @IBOutlet internal weak var weatherStateImageView: NSImageView!
    
    // MARK: - Life Cycle
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
#endif
