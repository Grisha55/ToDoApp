//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 29/06/2022.
//

import Foundation
import UIKit

class TaskManager {
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    var tasksURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else { fatalError() }
        return documentURL.appendingPathComponent("tasks.plist")
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        
        if let data = try? Data(contentsOf: tasksURL) {
            guard let dicts = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String : Any]] else { return }
            
            for dict in dicts {
                if let task = Task(dict: dict) {
                    tasks.append(task)
                }
            }
        }
    }
    
    deinit {
        save()
    }
    
    @objc
    func save() {
        let tasksDicts = self.tasks.map { $0.dict }
        guard tasksDicts.count > 0 else {
            try? FileManager.default.removeItem(at: tasksURL)
            return
        }
        
        guard let plistData = try? PropertyListSerialization.data(fromPropertyList: tasksDicts, format: .xml, options: (0)) else { return }
        
        do {
            try plistData.write(to: tasksURL, options: .atomic)
        } catch {
            print(error)
        }
    }
    
    func add(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    
    func task(at index: Int) -> Task {
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        var task = tasks.remove(at: index)
        task.isDone.toggle()
        doneTasks.append(task)
    }
    
    func uncheckTask(at index: Int) {
        var task = doneTasks.remove(at: index)
        task.isDone.toggle()
        tasks.append(task)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTask(at: index)
    }
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
