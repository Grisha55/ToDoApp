//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 29/06/2022.
//

import Foundation

class TaskManager {
    var tasksCount: Int {
        return tasks.count
    }
    
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    func add(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        let deletedTask = tasks.remove(at: index)
        doneTasks.append(deletedTask)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTask(at: index)
    }
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
