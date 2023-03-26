//
//  CreateScreenUITests.swift
//  TakeHomeProjectSwiftUIUITests
//
//  Created by Kevin on 24.03.23.
//

import XCTest

final class CreateScreenUITests: XCTestCase {
  
  private var app: XCUIApplication!
  
  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    app.launchArguments = ["-ui-testing"]
    app.launchEnvironment = [
      "-people-networking-success":"1",
      "-create-networking-success":"1"
    ]
    app.launch()
  }
  
  override func tearDown() {
    app = nil
  }
  
  func test_valid_form_submission_is_successful() {
    
    let createBtn = app.buttons["createBtn"]
    XCTAssertTrue(createBtn.waitForExistence(timeout: 5),
                  "The create button should be visible on the screen")
    
    createBtn.tap()
    
    let firstnameTxtField = app.textFields["firstNameTxtField"]
    let lastnameTxtField = app.textFields["lastNameTxtField"]
    let jobTxtField = app.textFields["jobTxtField"]
    
    firstnameTxtField.tap()
    firstnameTxtField.typeText("Kevin")
    
    lastnameTxtField.tap()
    lastnameTxtField.typeText("Topollaj")
    
    jobTxtField.tap()
    jobTxtField.typeText("iOS Developer")
    
    let submitBtn = app.buttons["submitBtn"]
    XCTAssertTrue(submitBtn.exists,
                  "The submit button should be visible on the screen")
    
    submitBtn.tap()
    
    XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5),
                  "There should be a navigation bar title People")
    
  }
}
