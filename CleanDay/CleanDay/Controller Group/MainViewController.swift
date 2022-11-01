//
//  ViewController.swift
//  CleanDay
//
//  Created by ChangYeop-Yang on 2022/10/31.
//

import Cocoa

import SystemKit

class ViewController: NSViewController {
    
    // MARK: - Object Properties
    private let viewModel = MainViewControllerModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.viewModel.setupLocationManager()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    final func test() async {
        
    }
}

