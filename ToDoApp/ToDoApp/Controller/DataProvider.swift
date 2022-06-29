//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 29/06/2022.
//

import Foundation
import UIKit

enum Section: Int {
    case todo
    case done
}

class DataProvider: NSObject {
    var taskManager: TaskManager?
}

extension DataProvider: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        guard let taskManager = taskManager else { return 0 }
        switch section {
        case .todo: return taskManager.tasksCount
        case .done: return taskManager.doneTasksCount
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TaskCell()
    }
    
}
