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

import SystemKit

public class ConfigureModel: SKClass {
    
    // MARK: - Object Properties
    public static var label: String = "com.ChangYeopYang.CleanDay.ConfigureModel"
    public static var identifier: String = "7011857F-E8DC-46B6-8313-C67C97BA590B"
    
    // MARK: - Struct
    public struct Configure: Codable {
        
        public let serviceKeys: ServiceKeys
        
        public enum CodingKeys: String, CodingKey {
            case serviceKeys = "ServiceKeys"
        }
    }
    
    public struct ServiceKeys: Codable {
        
        /// [Kakao Developers](https://developers.kakao.com)
        public let kakaoServiceKey: String
        
        /// [Korea Data Portal](https://www.data.go.kr)
        public let genericServiceKey: String
        
        /// [SwiftyBeaver](https://swiftybeaver.com)
        public let swiftyBeaverKey: BeaverServiceKeys
        
        // MARK: Inner Enum
        public enum CodingKeys: String, CodingKey {
            
            case kakaoServiceKey = "KakaoServiceKey"
            case genericServiceKey = "GenericServiceKey"
            case swiftyBeaverKey = "SwiftyBeaverKey"
        }
        
        // MARK: Inner Struct
        public struct BeaverServiceKeys: Codable {
            
            public let appID: String
            public let secret: String
            public let encryption: String
        }
    }
}

// MARK: - Public Extension ConfigureModel
public extension ConfigureModel {
    
    static func getAppConfigure(forResource: String = "Configure", ofType: String = "plist") -> Configure? {
                    
        guard let fileURLWithPath = Bundle.main.path(forResource: forResource, ofType: ofType) else {
            NSLog("[%@][%@] Error, Could't load Bunlde Resource Path", AppDelegate.label, AppDelegate.identifier)
            return nil
        }
        
        do {
            let contentsOf = URL(fileURLWithPath: fileURLWithPath)
            let data = try Data(contentsOf: contentsOf)
            
            return try PropertyListDecoder().decode(ConfigureModel.Configure.self, from: data)
        } catch let error as NSError {
            NSLog("[%@][%@] %@", AppDelegate.label, AppDelegate.identifier, error.description)
            return nil
        }
    }
}
#endif
