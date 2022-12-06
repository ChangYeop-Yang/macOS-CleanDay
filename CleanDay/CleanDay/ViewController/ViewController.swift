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

import CoreLocation
import SystemKit

internal class ViewController: BaseViewController, SKClass {
    
    // MARK: - Object Properties
    public static var label: String = "com.ChangYeopYang.CleanDay.ViewController"
    public static var identifier: String = "9BC867F3-FD37-42B2-AA96-D238FB14B527"
    
    private let viewModel = ViewControllerModel()
    
    // MARK: - Outlet Properties
    @IBOutlet weak var highlightTableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        Task {
            do {
                
                let result = try await self.viewModel.requestDust(serviceKey: "kvSiPNFHeegZG07hmSa+9NvgFMIeiU62lgyYDMlSdTCENKRsT8CodJnqgpie1kwq4ZIdo4355f6BPcgDi8Me4g==", stationName: "종로구")
                print(result)
                
                setupStatusBarWithDust(response: result!, type: .ultrafineDust)
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

// MARK: - Private Extension ViewController
private extension ViewController {
    
    final func initalize() {
        
        let nib = NSNib(nibNamed: ContentsCellView.identifier, bundle: nil)
        let forIdentifier = NSUserInterfaceItemIdentifier(ContentsCellView.identifier)
        
        highlightTableView.register(nib, forIdentifier: forIdentifier)
        highlightTableView.intercellSpacing = NSSize(width: 32, height: 16)
    }
}
#endif
