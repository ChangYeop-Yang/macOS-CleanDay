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
import PrivatePackage

public class DustModel: SKRequest {
    
    // MARK: - Object Properties
    public static let label = "com.ChangYeopYang.CleanDay.MeasurementModel"
    public static let identifier = "1FCC4150-571F-47C8-8E97-245C1A645757"
    public static let targetPath = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty"
    
    // MARK: - Struct
    public struct Response: Decodable {
        
        public let response: MeasurementModel.Field<DustModel.Item>
    }
    
    public struct Item: Decodable {
        
        /// 아황산가스 지수
        public let so2Grade: String
        
        /// 아황산가스 농도 (단위 : ppm)
        public let so2Value: String
        
        /// 아황산가스 플래그 - 상태정보 (점검및교정,장비점검,자료이상,통신장애)
        public let so2Flag: String?
        
        /// 일산화탄소 플래그 - 상태정보 (점검및교정,장비점검,자료이상,통신장애)
        public let coFlag: String?
        
        /// 일산화탄소 농도 (단위 : ppm)
        public let coValue: String
        
        /// 일산화탄소 지수
        public let coGrade: String
        
        /// 통합대기환경수치
        public let khaiValue: String
        
        /// 통합대기환경지수
        public let khaiGrade: String
        
        /// 미세먼지(PM2.5) 플래그 - 상태정보(점검및교정,장비점검,자료이상,통신장애)
        public let pm25Flag: String?
        
        /// 미세먼지(PM2.5) 농도 (단위 : ㎍/㎥)
        public let pm25Value: String
        
        /// 미세먼지(PM2.5) 등급
        public let pm25Grade: String
        
        /// 미세먼지(PM10) 플래그 - 상태정보(점검및교정,장비점검,자료이상,통신장애)
        public let pm10Flag: String?
        
        /// 미세먼지(PM10) 농도 (단위 : ㎍/㎥)
        public let pm10Value: String
        
        /// 미세먼지(PM10) 등급
        public let pm10Grade: String
        
        /// 오존 지수
        public let o3Grade: String
        
        /// 오존 플래그 - 상태정보(점검및교정,장비점검,자료이상,통신장애)
        public let o3Flag: String?
        
        /// 오존 농도 (단위 : ppm)
        public let o3Value: String
        
        /// 이산화질소 플래그 - 상태정보(점검및교정,장비점검,자료이상,통신장애)
        public let no2Flag: String?
        
        /// 이산화질소 농도 (단위 : ppm)
        public let no2Value: String
        
        /// 이산화질소 지수
        public let no2Grade: String
        
        /// 오염도측정 연-월-일 시간: 분
        public let dataTime: String
    }
    
    // MARK: - Enum
    public enum DataTerm: String {
        case daily = "DAILY"
        case month = "MONTH"
        case threeMonth = "3MONTH"
    }
}

// MARK: - Public Extension DustModel
public extension DustModel {
    
    static func createParameters(stationName: String,
                                 returnType: MeasurementModel.ReturnType = .json,
                                 dataTerm: DustModel.DataTerm = .daily) -> Parameters {

        let parameters: Parameters = ["serviceKey": PrivatePackage.DUST_AIR_SERVICE_KEY,
                                      "returnType": returnType.rawValue,
                                      "numOfRows": 100,
                                      "pageNo": 1,
                                      "stationName": stationName,
                                      "dataTerm": dataTerm.rawValue,
                                      "ver": 1.2]
        return parameters
    }
}
#endif
