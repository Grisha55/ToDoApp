//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 29/06/2022.
//

import Foundation
import UIKit

class DataProvider: NSObject {
    
}

extension DataProvider: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
