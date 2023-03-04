//
//  DinoViewsTests.swift
//  DinoViewsTests
//
//  Created by Agustin Cepeda on 24/02/23.
//

import XCTest
@testable import DinoViews

class DinoViewsTests: XCTestCase {


  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.

  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testCalculation() throws {
    let columnWidths: [CGFloat] = [100.0, 200.0, 300.0, 150.0, 220.0]
    let columnHeaderHeight: CGFloat = 60.0
    let rowHeight: CGFloat = 50.0
    let rowCount: Int = 2

    let expectedContentSize = CGSize(width: 970.0, height: 160.0)
    let expectedCalculation: [[CGRect]] = [
      [
        CGRect(origin: .zero, size: CGSize(width: 100.0, height: 60.0)),
        CGRect(origin: CGPoint(x: 100.0, y: 0.0), size: CGSize(width: 200.0, height: 60.0)),
        CGRect(origin: CGPoint(x: 300.0, y: 0.0), size: CGSize(width: 300.0, height: 60.0)),
        CGRect(origin: CGPoint(x: 600.0, y: 0.0), size: CGSize(width: 150.0, height: 60.0)),
        CGRect(origin: CGPoint(x: 750.0, y: 0.0), size: CGSize(width: 220.0, height: 60.0)),
      ],
      [
        CGRect(origin: CGPoint(x:0, y: 60.0), size: CGSize(width: 100.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 100.0, y: 60.0), size: CGSize(width: 200.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 300.0, y: 60.0), size: CGSize(width: 300.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 600.0, y: 60.0), size: CGSize(width: 150.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 750.0, y: 60.0), size: CGSize(width: 220.0, height: 50.0)),
      ],
      [
        CGRect(origin: CGPoint(x:0, y: 110), size: CGSize(width: 100.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 100.0, y: 110), size: CGSize(width: 200.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 300.0, y: 110), size: CGSize(width: 300.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 600.0, y: 110), size: CGSize(width: 150.0, height: 50.0)),
        CGRect(origin: CGPoint(x: 750.0, y: 110), size: CGSize(width: 220.0, height: 50.0)),
      ]
    ]

    let positionCalculator = CellPositionCalculatorImpl(columnWidths: columnWidths, columnHeaderHeight: columnHeaderHeight, rowHeight: rowHeight, rowCount: rowCount)

    XCTAssertEqual(positionCalculator.calculate(), expectedCalculation, "Error in calculation")
    XCTAssertEqual(positionCalculator.contentSize(), expectedContentSize, "Error in calculation")
  }

  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }

}
