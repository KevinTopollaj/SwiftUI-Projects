//
//  DetailsFailureUITests.swift
//  TakeHomeProjectSwiftUIUITests
//
//  Created by Kevin on 23.03.23.
//

import XCTest

final class DetailsFailureUITests: XCTestCase {

  private var app: XCUIApplication!
  
  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    // will tell us if it is a certain type of test by adding a flag
    app.launchArguments = ["-ui-testing"]
    // will be used as a value that could change and dictates how your code runs
    app.launchEnvironment = [
      "-people-networking-success": "1",
      "-details-networking-success": "0"
    ]
    app.launch()
  }
  
  override func tearDown() {
    app = nil
  }
  
  func test_alert_is_shown_when_screen_fails_to_loads() {
    
    let grid = app.otherElements["peopleGrid"]
    XCTAssertTrue(grid.waitForExistence(timeout: 5), "The lazyvgrid should exist on the screen")
    
    let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
    let gridItems = grid.buttons.containing(predicate)
    
    gridItems.firstMatch.tap()
    
    let alert = app.alerts.firstMatch
    XCTAssertTrue(alert.waitForExistence(timeout: 3), "There be an alert visible on the screen")
    
    XCTAssertTrue(alert.staticTexts["URL is not valid"].exists)
    XCTAssertTrue(alert.buttons["OK"].exists)
    
    XCTAssertTrue(app.staticTexts["#0"].exists)
    XCTAssertTrue(app.staticTexts["First Name"].exists)
    XCTAssertTrue(app.staticTexts["Last Name"].exists)
    XCTAssertTrue(app.staticTexts["Email"].exists)

    alert.buttons["OK"].tap()
    
    let textPlaceholderPredicate = NSPredicate(format: "label CONTAINS '-'")
    let placeholderItems = app.staticTexts.containing(textPlaceholderPredicate)
    
    XCTAssertEqual(placeholderItems.count, 3, "There should 3 placeholder items on the screen")
    
  }
}
