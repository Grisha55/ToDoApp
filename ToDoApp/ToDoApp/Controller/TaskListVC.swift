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
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail(withNotificaiton:)), name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc
    func showDetail(withNotificaiton notification: Notification) {
        guard let userInfo = notification.userInfo,
              let task = userInfo["task"] as? Task,
              let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC else { fatalError() }
        
        detailVC.task = task
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
