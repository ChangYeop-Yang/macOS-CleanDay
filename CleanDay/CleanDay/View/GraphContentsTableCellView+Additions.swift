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
import Charts

// MARK: - Private Extension GraphContentsTableCellView
private extension GraphContentsTableCellView {
    
    final func drawChartView(parent: NSView) {
        
        
    }
}

// MARK: - Interal Extension GraphContentsTableCellView
internal extension GraphContentsTableCellView {
    
    final func initalize() {
        
        #if DEBUG
            NSLog("[%@][%@] Initalize, GraphContentsTableCellView", Self.label, Self.identifier)
        #endif
        
        self.layer?.cornerRadius = self.cornerRadius
        self.layer?.masksToBounds = self.masksToBounds
        self.layer?.backgroundColor = self.backgroundColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Public Extension GraphContentsTableCellView
public extension GraphContentsTableCellView {
    
    final func setup(title: String, date: String, systemSymbolName: String) {
        
        #if DEBUG
            NSLog("[%@][%@] Action, Setup GraphContentsTableCellView SubViews", Self.label, Self.identifier)
        #endif
        
        self.dateLabel.stringValue = date
        self.titleLabel.stringValue = title
        
        self.logoImageView.image = NSImage(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
        
        drawChartView(parent: self.chartsView)
    }
}
#endif
