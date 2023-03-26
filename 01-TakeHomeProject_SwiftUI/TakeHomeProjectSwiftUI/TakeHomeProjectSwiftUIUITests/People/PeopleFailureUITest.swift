//
//  PeopleFailureUITest.swift
//  TakeHomeProjectSwiftUIUITests
//
//  Created by Kevin on 21.03.23.
//

import XCTest

final class PeopleFailureUITest: XCTestCase {

  private var app: XCUIApplication!
  
  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    // will tell us if it is a certain type of test by adding a flag
    app.launchArguments = ["-ui-testing"]
    // will be used as a value that could change and dictates how your code runs
    app.launchEnvironment = ["-people-networking-success": "0"]
    app.launch()
  }
  
  override func tearDown() {
    app = nil
  }
  
  func test_alert_is_shown_when_screen_fails_to_loads() {

      let alert = app.alerts.firstMatch
      XCTAssertTrue(alert.waitForExistence(timeout: 3), "There should be an alert on the screen")
      
      XCTAssertTrue(alert.staticTexts["URL is not valid"].exists)
      XCTAssertTrue(alert.buttons["Retry"].exists)
  }
  
}
