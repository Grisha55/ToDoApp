//
//  TaskTests.swift
//  ToDoAppTests
//
//  Created by Григорий Виняр on 29/06/2022.
//

import XCTest
@testable import ToDoApp

class TaskTests: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task)
    }
    
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertTrue(task.description == "Bar")
    }
    
    func testTaskInitsWithData() {
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Bar", description: "Baz", location: location)
        
        XCTAssertEqual(location, task.location)
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        let locationDictionary: [String : Any] = ["name" : "Baz"]
        let dictionary: [String : Any] = ["title" : "Foo",
                                          "description" : "Bar",
                                          "date" : date,
                                          "location" : locationDictionary]
        
        let createdTask = Task(dict: dictionary)
        
        XCTAssertEqual(task, createdTask)
    }
    
    func testCanBeSerializedIntoDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        let generatedTask = Task(dict: task.dict)
        
        XCTAssertEqual(task, generatedTask)
    }

}
