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
        try super.setUpWithError()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: String(describing: TaskListVC.self))
        sut = vc as? TaskListVC
        newTaskVC = sut.presentedViewController as? NewTaskVC
        sut?.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        newTaskVC = nil
        
        try super.tearDownWithError()
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
    
    func testWhenViewAppearedTableViewReloaded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }
    
    func testTappingCellSendsNotification() {
        let task = Task(title: "Foo")
        sut.dataProvider.taskManager?.add(task: task)
        
        let exp = expectation(forNotification: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil) { notification -> Bool in
            
            guard let taskFromNotification = notification.userInfo?["task"] as? Task else { return false }
            return task == taskFromNotification
        }
        
        DispatchQueue.main.async {
            exp.fulfill()
        }
        
        guard let tableView = sut.tableView else { return }
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSelectedCellNotificationPushesDetailVC() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        
        sut.loadViewIfNeeded()
        let task1 = Task(title: "Foo")
        let task2 = Task(title: "Bar")
        sut.dataProvider.taskManager?.add(task: task1)
        sut.dataProvider.taskManager?.add(task: task2)
        
        NotificationCenter.default.post(name: NSNotification.Name("DidSelectRow notification"), object: self, userInfo: ["task" : task2])
        
        guard let detailVC = mockNavigationController.pushedVC as? DetailVC else {
            XCTFail()
            return
        }
        
        detailVC.loadViewIfNeeded()
        XCTAssertNotNil(detailVC.titleLabel)
        XCTAssertEqual(detailVC.task, task2)
    }
    
}

extension TaskListVCTests {
    
    class MockTableView: UITableView {
        var isReloaded = false
        override func reloadData() {
            isReloaded = true
        }
    }
}

extension TaskListVCTests {
    
    class MockNavigationController: UINavigationController {
        var pushedVC: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedVC = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
