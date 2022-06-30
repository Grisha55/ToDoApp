//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 29/06/2022.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func configure(withTask task: Task) {
        self.titleLabel.text = task.title
    }
    

}
