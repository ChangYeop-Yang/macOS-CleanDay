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
import Foundation

// MARK: - Enum
public enum StoryboardInfo: String {
    
    case main = "Main"
    
    // MARK: Enum Properties
    public var name: String { return self.rawValue }
}

public enum ViewControllerInfo: String {
    
    case viewController = "ViewController"
    
    // MARK: Enum Proerpties
    public var name: String { return self.rawValue }
}

// MARK: - Struct
public struct ConfigureResource: Codable {
    
    public let ofType: String = "plist"
    public let forResource: String = "Configure"
    
    public var configure: NSDictionary {
        
        guard let fileURLWithPath = Bundle.main.path(forResource: self.forResource, ofType: self.ofType) else {
            return NSDictionary.init()
        }
        
        let contentsOf = URL(fileURLWithPath: fileURLWithPath)
        return NSDictionary(contentsOf: contentsOf) ?? NSDictionary.init()
    }
}
#endif
