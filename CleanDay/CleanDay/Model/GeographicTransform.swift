/*
* Copyright (c) 2020 양창엽. All rights reserved.
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
import CoreLocation

import SystemKit
import Alamofire

// https://developers.kakao.com/docs/latest/ko/local/dev-guide
public class GeographicTransform: SKRestAPI {
    
    // MARK: - Object Properties
    public static let label = "com.ChangYeopYang.CleanDay.GeographicTransform"
    public static let identifier = "B58415A1-2D2C-41FC-BAE8-C35FD7B40226"
    public static let targetPath = "https://dapi.kakao.com/v2/local/geo/transcoord.json"
    
    // MARK: - Enum
    public enum GeographicCoordinateType: String {
        case WGS84 = "WGS84"
        case WCONGNAMUL = "WCONGNAMUL"
        case CONGNAMUL = "CONGNAMUL"
        case WTM = "WTM"
        case TM = "TM"
    }

    // MARK: - Struct
    public struct Geographic: Decodable {
        let meta: GTMeta
        let documents: [GTDocuments]
    }

    public struct GTMeta: Decodable {
        
        let totalCount: Int

        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
        }
    }

    public struct GTDocuments: Decodable {
        
        let mapX: Double
        let mapY: Double

        enum CodingKeys: String, CodingKey {
            case mapX = "y"     // y 좌표, 경위도인 경우 latitude
            case mapY = "x"     // x 좌표, 경위도인 경우 longitude
        }
    }
}

// MARK: - Public Extension GeographicTransform
public extension GeographicTransform {
    
    static func createHeader(keyValue: String) -> HTTPHeaders {
        
        var header: HTTPHeaders = HTTPHeaders()
        
        let value = String(format: "KakaoAK %@", keyValue)
        header.add(name: "Authorization", value: value)
        
        #if DEBUG
            NSLog("[%@][%@] %@", GeographicTransform.label, GeographicTransform.identifier, header.description)
        #endif
        
        return header
    }
    
    static func createParameters(coordinate: CLLocationCoordinate2D,
                                 inputType: GeographicCoordinateType = .WGS84,
                                 outputType: GeographicCoordinateType) -> Parameters {
        
        var parameters: Parameters = Parameters()
        
        parameters["x"] = coordinate.longitude
        parameters["y"] = coordinate.latitude
        parameters["input_coord"] = inputType.rawValue
        parameters["output_coord"] = outputType.rawValue
        
        #if DEBUG
            NSLog("[%@][%@] %@", GeographicTransform.label, GeographicTransform.identifier, parameters.description)
        #endif
        
        return parameters
    }
}
#endif
