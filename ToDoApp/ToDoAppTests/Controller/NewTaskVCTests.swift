//
//  NewTaskVCTests.swift
//  ToDoAppTests
//
//  Created by Григорий Виняр on 03/07/2022.
//

import XCTest
@testable import ToDoApp

class NewTaskVCTests: XCTestCase {

    var sut: NewTaskVC!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskVC.self)) as? NewTaskVC
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasTitleTF() {
        XCTAssertTrue(sut.titleTF.isDescendant(of: sut.view))
    }
    
    func testHasLocationTF() {
        XCTAssertTrue(sut.locationTF.isDescendant(of: sut.view))
    }
    
    func testHasDateTF() {
        XCTAssertTrue(sut.dateTF.isDescendant(of: sut.view))
    }
    
    func testHasAdressTF() {
        XCTAssertTrue(sut.adressTF.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
}
