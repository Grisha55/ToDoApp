//
//  Task.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 29/06/2022.
//

import Foundation

struct Task {
    var title: String
    var description: String?
    private(set) var data: Date?
    
    init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
    }
}
