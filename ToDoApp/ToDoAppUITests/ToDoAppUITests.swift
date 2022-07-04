//
//  ToDoAppUITests.swift
//  ToDoAppUITests
//
//  Created by Григорий Виняр on 29/06/2022.
//

import XCTest
@testable import ToDoApp

class ToDoAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()
        
        let titleTF = app.textFields["Title"]
        XCTAssertTrue(titleTF.exists)
        titleTF.tap()
        titleTF.typeText("Foo")
        
        let locationTF = app.textFields["Location"]
        XCTAssertTrue(locationTF.exists)
        locationTF.tap()
        locationTF.typeText("Bar")
        
        let dateTF = app.textFields["Date"]
        XCTAssertTrue(dateTF.exists)
        dateTF.tap()
        dateTF.typeText("Buz")
        
        let addressTF = app.textFields["Address"]
        XCTAssertTrue(addressTF.exists)
        addressTF.tap()
        addressTF.typeText("Yaroslavl")
        
        let descriptionTF = app.textFields["Description"]
        XCTAssertTrue(descriptionTF.exists)
        descriptionTF.tap()
        descriptionTF.typeText("Desc")
        
        let saveButton = app.buttons["Сохранить"]
        XCTAssertTrue(saveButton.exists)
        saveButton.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
