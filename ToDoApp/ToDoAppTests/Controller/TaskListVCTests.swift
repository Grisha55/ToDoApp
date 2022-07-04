//
//  TaskListVCTests.swift
//  ToDoAppTests
//
//  Created by Григорий Виняр on 29/06/2022.
//

import XCTest
@testable import ToDoApp

class TaskListVCTests: XCTestCase {
    
    var sut: TaskListVC!
    var newTaskVC: NewTaskVC!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: TaskListVC.self))
        sut = vc as? TaskListVC
        newTaskVC = sut.presentedViewController as? NewTaskVC
        sut?.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateEqalsTableViewDataSource() {
        XCTAssertEqual(sut.tableView.delegate as? DataProvider, sut.tableView.dataSource as? DataProvider)
    }
    
    func testTaskListVCHasAddBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListVC, sut)
    }
    
    func presentingNewTaskViewController() -> NewTaskVC {
        
        guard let newTaskButton = sut.navigationItem.rightBarButtonItem, let action = newTaskButton.action else {
            return NewTaskVC()
        }
        
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        
        let newTaskVC = sut.presentedViewController as! NewTaskVC
        return newTaskVC
    }
    
    func testAddNewTaskPresentsNewTaskVC() {
        let newTaskVC = presentingNewTaskViewController()
        XCTAssertNotNil(newTaskVC.titleTF)
    }
    
    func testSharesSameTaskManagerWithNewTaskVC() {
        let newTaskVC = presentingNewTaskViewController()
        XCTAssertTrue(newTaskVC.taskManager === sut.dataProvider.taskManager)
    }
    
}
