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

public class DustStationModel: SKRequest {
    
    // MARK: - Object Properties
    public static var label = "com.ChangYeopYang.CleanDay.DustStationModel"
    public static var identifier = "3933EEEA-1DE2-4E3D-8898-51F2D20E2870"
    public static let targetPath = "http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList"
    
    // MARK: - Struct
    public struct Response: Decodable {
        
        /// TM 좌표를 입력하여 입력된 좌표 주변 측정소 정보와 입력 좌표와의 거리 조회 기능 제공합니다.
        public let response: MeasurementModel.Field<DustStationModel.Item>
    }
    
    public struct Item: Decodable {
        
        /// 요청한 TM 좌표와 측정소간의 거리 (km 단위)
        public let tm: Double
        
        /// 측정소가 위치한 주소
        public let addr: String
        
        /// 측정소 이름
        public let stationName: String
    }
}

// MARK: - Public Extension DustStationModel
public extension DustStationModel {
    
    static func createParameters(serviceKey: String, tmX: Double, tmY: Double,
                                 returnType: MeasurementModel.ReturnType = .json) -> Parameters {
        
        let parameters: Parameters = ["serviceKey": serviceKey, "returnType": returnType.rawValue,
                                      "tmX": tmX, "tmY": tmY, "ver": "1.0"]
        
        return parameters
    }
}
#endif
