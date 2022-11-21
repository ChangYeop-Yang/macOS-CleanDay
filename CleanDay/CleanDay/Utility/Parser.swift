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
import Alamofire

public class Parser: NSObject, SKClass {
    
    // MARK: - Object Properties
    public static var label: String = "com.ChangYeopYang.CleanDay.Parser"
    public static var identifier: String = "FBE632CC-5430-4AAE-AA83-E1645FE49215"
    public static let shared = Parser()
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Session(configuration: configuration)
      }()
    
    // MARK: - Initalize
    private override init() { super.init() }
}

// MARK: - Private Extension Parser
private extension Parser {
    
    final func createEncodeURL(url: String) -> URL? {
        
        // 한글 및 특수문자가 포함 된 주소를 인코딩 작업을 수행합니다.
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            log.error("[Parser] Error, Could't Encode URLRequest’s URL")
            return nil
        }
        
        return URL(string: encodedURL)
    }
}

// MARK: - Public Extension Parser
public extension Parser {
    
    final func requestJSON<T: Decodable>(url: String, type: T.Type,
                                         method: HTTPMethod = .get,
                                         encoding: ParameterEncoding = URLEncoding.default,
                                         headers: Optional<HTTPHeaders> = nil,
                                         parameters: Optional<Parameters> = nil) async throws -> Optional<T> {
        
        log.info("[Parser] Action, URL Session Request JSON: \(url)")
        
        guard let result = createEncodeURL(url: url) else { return nil }
        
        return try await self.session.request(result, method: method,
                                              parameters: parameters, encoding: encoding,
                                              headers: headers).serializingDecodable().value
    }
    
    final func requestString(url: String,
                             method: HTTPMethod = .get,
                             parameters: Optional<Parameters> = nil) async throws -> Optional<String> {
        
        log.info("[Parser] Action, URL Session Request String: \(url)")
        
        guard let result = createEncodeURL(url: url) else { return nil }
        
        return try await self.session.request(result, method: method, parameters: parameters,
                                              encoding: URLEncoding.default).serializingString().value
    }
}

#endif
