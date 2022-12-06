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

@IBDesignable
public class ContentsCellView: NSTableCellView, SKClass {
    
    // MARK: - Object Properties
    public static let label: String = "com.ChangYeopYang.CleanDay.ContentsCellView"
    public static let identifier: String = "ContentsCellView"
    
    // MARK: - Outlet Properties
    @IBOutlet private weak var titleLabel: NSTextField!
    @IBOutlet private weak var valueLabel: NSTextField!
    @IBOutlet private weak var contentsLabel: NSTextField!
    @IBOutlet private weak var categoryImageView: NSImageView!
    
    // MARK: - IBInspectable Properties
    @IBInspectable public var masksToBounds: Bool = true
    @IBInspectable public var cornerRadius: CGFloat = CGFloat.zero
    @IBInspectable public var backgroundColor: CGColor = NSColor.blue.cgColor
    
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
        initalize()
        
        self.titleLabel.stringValue = "titleLabel"
        self.valueLabel.stringValue = "50%"
        self.contentsLabel.stringValue = "contentsLabel"
    }
}

// MARK: - Private Extension ContentsView
private extension ContentsCellView {
    
    final func initalize() {
        
        self.layer?.cornerRadius = self.cornerRadius
        self.layer?.masksToBounds = self.masksToBounds
        self.layer?.backgroundColor = self.backgroundColor
    }
}

// MARK: - Public Extension ContentsView
public extension ContentsCellView {
    
    final func setValue(title: String, value: String, contents: String, image: NSImage) {
        
        self.titleLabel.stringValue = title
        self.valueLabel.stringValue = value
        self.contentsLabel.stringValue = contents
        
        self.categoryImageView.image = image
    }
}
#endif
