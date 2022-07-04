//
//  NewTaskVC.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 03/07/2022.
//

import UIKit
import CoreLocation

class NewTaskVC: UIViewController {

    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var locationTF: UITextField!
    @IBOutlet var dateTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var descriptionTF: UITextField!
    
    @IBAction func save() {
        
        guard let titleString = titleTF.text else { return }
        guard let locationString = locationTF.text else { return }
        guard let dateText = dateTF.text else { return }
        
        let date = dateFormatter.date(from: dateText)
        let descriptionString = descriptionTF.text
        let addressString = addressTF.text
        
        guard let address = addressString else { return }
        geocoder.geocodeAddressString(address) { [weak self](placemarks, error) in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString, coordinate: coordinate)
            let task = Task(title: titleString, description: descriptionString, location: location, date: date)
            
            self?.taskManager.add(task: task)
            
            DispatchQueue.main.async {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancel() {
        dismiss(animated: true)
    }
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
    

}
