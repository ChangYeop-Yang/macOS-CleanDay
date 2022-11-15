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
import Alamofire

public class MeasurementModel: SKClass {
    
    // MARK: - Object Properties
    public static let label: String = "com.ChangYeopYang.CleanDay.MeasurementModel"
    public static let identifier: String = "9967E18A-8CEC-4DBD-8D88-794D6970AC9B"
    
    // MARK: - Struct
    public struct Field<T: Decodable>: Decodable {
        public let body: MeasurementModel.Body<T>
        public let header: MeasurementModel.Header
    }

    public struct Header: Decodable {
        public let resultMsg: String
        public let resultCode: String
    }

    public struct Body<T: Decodable>: Decodable {
        public let totalCount: Int
        public let pageNo: Int
        public let numOfRows: Int
        public let items: [T]
    }
    
    // MARK: - Enum
    public enum ReturnType: String {
        case xml = "xml"
        case json = "json"
    }
}
#endif
