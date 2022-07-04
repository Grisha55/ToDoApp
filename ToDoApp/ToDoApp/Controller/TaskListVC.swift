//
//  TaskListVC.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 29/06/2022.
//

import UIKit

class TaskListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    
    @IBAction func addNewTask(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: NewTaskVC.self)) as? NewTaskVC {
            vc.taskManager = self.dataProvider.taskManager
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
        taskManager.add(task: Task(title: "Test task"))
    }

}

