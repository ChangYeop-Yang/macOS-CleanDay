/*
 * Copyright (c) 2022 Universal-SystemKit. All rights reserved.
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

internal class MainViewControllerModel: NSObject {
    
    // MARK: - Object Properties
    private var manager: SKCoreLocation?
}

// MARK: - Private Extension MainViewControllerModel
private extension MainViewControllerModel {
    
    
}

// MARK: - Internal Extension MainViewControllerModel
internal extension MainViewControllerModel {
    
    final func setupLocationManager() {
        
        // 사용자의 위치 정보를 가져오기 위하여 CoreLocation 권한 설정 작업을 수행합니다.
        self.manager = SKCoreLocation(delegate: self)
        manager?.requestAuthorization()
        
        print(manager?.recentlyLocation)
    }
}

// MARK: - Extension CLLocationManagerDelegate
extension MainViewControllerModel: CLLocationManagerDelegate {
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
