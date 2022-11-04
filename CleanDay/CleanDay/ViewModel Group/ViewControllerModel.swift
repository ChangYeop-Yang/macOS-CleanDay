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

import SystemKit

import Foundation
import CoreLocation

internal class ViewControllerModel: NSObject, SKClass {
    
    // MARK: - Object Properties
    public static var label: String = "com.ChangYeopYang.CleanDay.ViewControllerModel"
    public static var identifier: String = "EE38D2FA-39D8-47CB-AD71-E19666B054A3"
    
    private var manager: SKCoreLocation? = nil
}

// MARK: - Private Extension ViewControllerModel
private extension ViewControllerModel {
    
    
}

// MARK: - Internal Extension ViewControllerModel
internal extension ViewControllerModel {
    
    final func setupLocationManager() {
        
        // 사용자의 위치 정보를 가져오기 위하여 CoreLocation 권한 설정 작업을 수행합니다.
        self.manager = SKCoreLocation(delegate: self)
        manager?.requestAuthorization()
    }
}

// MARK: - Extension CLLocationManagerDelegate
extension ViewControllerModel: CLLocationManagerDelegate {
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
