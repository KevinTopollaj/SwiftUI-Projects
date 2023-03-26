//
//  CreateScreenUIValidTests.swift
//  TakeHomeProjectSwiftUIUITests
//
//  Created by Kevin on 23.03.23.
//

import XCTest

final class CreateScreenUIValidTests: XCTestCase {

  private var app: XCUIApplication!
  
  override func setUp() {
      continueAfterFailure = false
      app = XCUIApplication()
      app.launchArguments = ["-ui-testing"]
      app.launchEnvironment = ["-people-networking-success":"1"]
      app.launch()
  }
  
  override func tearDown() {
      app = nil
  }
  
  func test_when_create_is_tapped_create_view_is_presented() {
    
    let createBtn = app.buttons["createBtn"]
    XCTAssertTrue(createBtn.waitForExistence(timeout: 5),
                  "There create button should be visible on the screen")
    
    createBtn.tap()
   
    XCTAssertTrue(app.navigationBars["Create"].waitForExistence(timeout: 5))
    XCTAssertTrue(app.buttons["doneBtn"].exists)
    XCTAssertTrue(app.buttons["submitBtn"].exists)
    XCTAssertTrue(app.textFields["firstNameTxtField"].exists)
    XCTAssertTrue(app.textFields["lastNameTxtField"].exists)
    XCTAssertTrue(app.textFields["jobTxtField"].exists)
  }
  
  func test_when_done_is_tapped_create_view_is_dismissed() {
      
      let createBtn = app.buttons["createBtn"]
      XCTAssertTrue(createBtn.waitForExistence(timeout: 5),
                    "There create button should be visible on the screen")
      
      createBtn.tap()
      
      let doneBtn = app.buttons["doneBtn"]
      XCTAssertTrue(doneBtn.exists)

      doneBtn.tap()
      
      XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5),
                    "There should be a navigation bar with the title people")
      
  }
}
