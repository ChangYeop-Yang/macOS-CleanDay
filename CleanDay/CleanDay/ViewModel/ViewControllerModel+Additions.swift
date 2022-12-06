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
import WeatherKit
import CoreLocation

// MARK: - Private Extension ViewControllerModel
private extension ViewControllerModel {
    
    
}

// MARK: - Internal Extension ViewControllerModel
internal extension ViewControllerModel {
    
    final func requestWeatherKit(location: CLLocation) async throws -> Weather {
        
        #if DEBUG
            log.info("[ViewControllerModel] Action, Request Apple WeatherKit: \(location)")
        #endif
                
        return try await self.weatherService.weather(for: location)
    }
    
    typealias Geographic = Optional<GeographicTransform.Geographic>
    final func requestTransformGeographic(serviceKey: String, coordinate: CLLocationCoordinate2D,
                                          outputType: GeographicTransform.GeographicCoordinateType) async throws -> Geographic {
    
        #if DEBUG
            log.info("[ViewControllerModel] Action, Request Geographic Tranform: \(coordinate)")
        #endif
        
        let headers = GeographicTransform.createHeader(keyValue: serviceKey)
        let parameters = GeographicTransform.createParameters(coordinate: coordinate, outputType: outputType)
        
        return try await Parser.shared.requestJSON(url: GeographicTransform.targetPath,
                                                   type: GeographicTransform.Geographic.self,
                                                   headers: headers, parameters: parameters)
    }
    
    typealias DustStation = Optional<DustStationModel.Response>
    final func requestDustStation(serviceKey: String, tmX: Double, tmY: Double) async throws -> DustStation {
        
        #if DEBUG
            log.info("[ViewControllerModel] Action, Request Measurement Dust Station")
        #endif
        
        let parameters = DustStationModel.createParameters(serviceKey: serviceKey, tmX: tmX, tmY: tmY)
        
        return try await Parser.shared.requestJSON(url: DustStationModel.targetPath,
                                                   type: DustStationModel.Response.self, parameters: parameters)
    }
    
    typealias Dust = Optional<DustModel.Response>
    final func requestDust(serviceKey: String, stationName: String) async throws -> Dust {
        
        #if DEBUG
            log.info("[ViewControllerModel] Action, Request Measurement Dust: \(stationName)")
        #endif
        
        let parameters = DustModel.createParameters(serviceKey: serviceKey, stationName: stationName)
        
        return try await Parser.shared.requestJSON(url: DustModel.targetPath,
                                                   type: DustModel.Response.self, parameters: parameters)
    }
}
#endif
