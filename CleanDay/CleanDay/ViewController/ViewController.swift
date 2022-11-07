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

import SystemKit

class ViewController: BaseViewController, SKClass {
    
    // MARK: - Object Properties
    public static var label: String = "com.ChangYeopYang.CleanDay.ViewController"
    public static var identifier: String = "9BC867F3-FD37-42B2-AA96-D238FB14B527"
    
    private var viewModel = ViewControllerModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Do any additional setup after loading the view.
        Task {
            do {
                let result = try await Parser.shared.requestJSON(url: "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?serviceKey=kvSiPNFHeegZG07hmSa+9NvgFMIeiU62lgyYDMlSdTCENKRsT8CodJnqgpie1kwq4ZIdo4355f6BPcgDi8Me4g==&returnType=json&numOfRows=100&pageNo=1&stationName=호매실&dataTerm=DAILY&ver=1.0", type: DustResponse.self,
                                                             method: .get)
                print(result)
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
#endif
