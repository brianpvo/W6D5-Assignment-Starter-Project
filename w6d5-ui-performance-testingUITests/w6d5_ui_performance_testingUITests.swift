//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Brian Vo on 2018-05-18.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        deleteAllMeals()
    }
    
    func testExample() {
        addNewMeal(mealName: "Burger", numberOfCalories: 300)
    }
    
    func testShowMealDetail()  {
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Burger - 300"]/*[[".cells.staticTexts[\"Burger - 300\"]",".staticTexts[\"Burger - 300\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.staticTexts["detailViewControllerLabel"].label == "Burger - 300", "Expected to be displaying Burger - 300")
        app.navigationBars["Detail"].buttons["Master"].tap()
        
    }
    
    func testDeleteMeal() {
        deleteMeal(mealName: "Burger", numberOfCalories: 300)
    }
    
    func deleteMeal(mealName: String, numberOfCalories: Int) {
        let staticText = app.tables.staticTexts["\(mealName) - \(numberOfCalories)"]
        if staticText.exists {
            staticText.swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }
    
    func addNewMeal(mealName: String, numberOfCalories: Int) {
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(mealName)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText(String(numberOfCalories))
        addAMealAlert.buttons["Ok"].tap()
    }
    
    func deleteAllMeals() {
        let tableCells = app.tables.cells
        while tableCells.count > 0 {
            tableCells.element(boundBy: 0).swipeLeft()
            app.tables.buttons["Delete"].tap()
        }
    }
    
}
