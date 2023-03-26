//
//  PeopleScreenUITests.swift
//  TakeHomeProjectSwiftUIUITests
//
//  Created by Kevin on 20.03.23.
//

import XCTest

final class PeopleScreenUITests: XCTestCase {

  private var app: XCUIApplication!
  
  override func setUp() {
    continueAfterFailure = false
    app = XCUIApplication()
    // will tell us if it is a certain type of test by adding a flag
    app.launchArguments = ["-ui-testing"]
    // will be used as a value that could change and dictates how your code runs
    app.launchEnvironment = ["-people-networking-success": "1"]
    app.launch()
  }
  
  override func tearDown() {
    app = nil
  }
  
  func test_grid_has_correct_number_of_items_when_screen_loads() {
   
      let grid = app.otherElements["peopleGrid"]
      XCTAssertTrue(grid.waitForExistence(timeout: 5), "The people lazygrid should be visible")
      
      let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
      let gridItems = grid.buttons.containing(predicate)
      XCTAssertEqual(gridItems.count, 6, "There should be 6 items on the screen")
      
      XCTAssertTrue(gridItems.staticTexts["#1"].exists)
      XCTAssertTrue(gridItems.staticTexts["George Bluth"].exists)

      XCTAssertTrue(gridItems.staticTexts["#2"].exists)
      XCTAssertTrue(gridItems.staticTexts["Janet Weaver"].exists)
      
      XCTAssertTrue(gridItems.staticTexts["#3"].exists)
      XCTAssertTrue(gridItems.staticTexts["Emma Wong"].exists)
      
      XCTAssertTrue(gridItems.staticTexts["#4"].exists)
      XCTAssertTrue(gridItems.staticTexts["Eve Holt"].exists)
      
      XCTAssertTrue(gridItems.staticTexts["#5"].exists)
      XCTAssertTrue(gridItems.staticTexts["Charles Morris"].exists)
      
      XCTAssertTrue(gridItems.staticTexts["#6"].exists)
      XCTAssertTrue(gridItems.staticTexts["Tracey Ramos"].exists)
  }
  
}
