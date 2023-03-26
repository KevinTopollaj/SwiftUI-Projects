//
//  CreateScreenFormValidationUITests.swift
//  TakeHomeProjectSwiftUIUITests
//
//  Created by Kevin on 23.03.23.
//

import XCTest

final class CreateScreenFormValidationUITests: XCTestCase {

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
  
  func test_when_all_form_fields_is_empty_first_name_error_is_shown() {
     
      let createBtn = app.buttons["createBtn"]
      XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "The create button should be visible on the screen")
      
      createBtn.tap()
      
      let submitBtn = app.buttons["submitBtn"]
      XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "The submit button should be visible on the screen")
      
      submitBtn.tap()
      
      let alert = app.alerts.firstMatch
      let alertBtn = alert.buttons.firstMatch
      
      XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
      XCTAssertTrue(alert.staticTexts["First Name can not be empty!"].exists)
      XCTAssertEqual(alertBtn.label, "OK")
      
      alertBtn.tap()
      
      XCTAssertTrue(app.staticTexts["First Name can not be empty!"].exists)
      
      XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
  }
  
  func test_when_first_name_form_field_is_empty_first_name_error_is_shown() {

      let createBtn = app.buttons["createBtn"]
      XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "The create button should be visible on the screen")
      
      createBtn.tap()
      
      let lastnameTxtField = app.textFields["lastNameTxtField"]
      let jobTxtField = app.textFields["jobTxtField"]
      
      lastnameTxtField.tap()
      lastnameTxtField.typeText("Topollaj")
      
      jobTxtField.tap()
      jobTxtField.typeText("iOS Developer")
      
      let submitBtn = app.buttons["submitBtn"]
      XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "The submit button should be visible on the screen")
      
      submitBtn.tap()
      
      let alert = app.alerts.firstMatch
      let alertBtn = alert.buttons.firstMatch
      
      XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
      XCTAssertTrue(alert.staticTexts["First Name can not be empty!"].exists)
      XCTAssertEqual(alertBtn.label, "OK")
      
      alertBtn.tap()
      
      XCTAssertTrue(app.staticTexts["First Name can not be empty!"].exists)
      
      XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
  }
  
  func test_when_last_name_form_field_is_empty_last_name_error_is_shown() {

      let createBtn = app.buttons["createBtn"]
      XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "The create button should be visible on the screen")
      
      createBtn.tap()
      
      let firstnameTxtField = app.textFields["firstNameTxtField"]
      let jobTxtField = app.textFields["jobTxtField"]
      
      firstnameTxtField.tap()
      firstnameTxtField.typeText("Kevin")
      
      jobTxtField.tap()
      jobTxtField.typeText("iOS Developer")
      
      let submitBtn = app.buttons["submitBtn"]
      XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "The submit button should be visible on the screen")
      
      submitBtn.tap()
      
      let alert = app.alerts.firstMatch
      let alertBtn = alert.buttons.firstMatch
      
      XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
      XCTAssertTrue(alert.staticTexts["Last Name can not be empty!"].exists)
      XCTAssertEqual(alertBtn.label, "OK")
      
      alertBtn.tap()
      
      XCTAssertTrue(app.staticTexts["Last Name can not be empty!"].exists)
      
      XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
  }
  
  func test_when_job_form_field_is_empty_job_error_is_shown() {

      let createBtn = app.buttons["createBtn"]
      XCTAssertTrue(createBtn.waitForExistence(timeout: 5), "The create button should be visible on the screen")
      
      createBtn.tap()
      
      let firstnameTxtField = app.textFields["firstNameTxtField"]
      let lastnameTxtField = app.textFields["lastNameTxtField"]
      
      firstnameTxtField.tap()
      firstnameTxtField.typeText("Kevin")
      
      lastnameTxtField.tap()
      lastnameTxtField.typeText("Topollaj")
      
      let submitBtn = app.buttons["submitBtn"]
      XCTAssertTrue(submitBtn.waitForExistence(timeout: 5), "The submit button should be visible on the screen")
      
      submitBtn.tap()
      
      let alert = app.alerts.firstMatch
      let alertBtn = alert.buttons.firstMatch
      
      XCTAssertTrue(alert.waitForExistence(timeout: 5), "There should be an alert on the screen")
      XCTAssertTrue(alert.staticTexts["Job can not be empty!"].exists)
      XCTAssertEqual(alertBtn.label, "OK")
      
      alertBtn.tap()
      
      XCTAssertTrue(app.staticTexts["Job can not be empty!"].exists)
      
      XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen")
  }
}
