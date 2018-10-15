//
//  FirstViewControllerTests.swift
//  WunderAppTests
//
//  Created by Hao Wu on 2018/10/9.
//  Copyright © 2018年 Hao Wu. All rights reserved.
//

import XCTest
import UIKit
@testable import WunderApp

class FirstViewControllerTests: XCTestCase {

    var controller: FirstViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        controller = vc
    }
    
    func testCarsHasExpectedItemsCount() {
        controller.loadInitialData()
        
        XCTAssert(controller.cars.count == 423, "Cars did't have expected number of items")
    }

}
