//
//  NewTaskVCTests.swift
//  ToDoAppTests
//
//  Created by Григорий Виняр on 03/07/2022.
//

import XCTest
@testable import ToDoApp
import CoreLocation

class NewTaskVCTests: XCTestCase {

    var sut: NewTaskVC!
    var placemark: MockClPlacemark!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskVC.self)) as? NewTaskVC
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasTitleTF() {
        XCTAssertTrue(sut.titleTF.isDescendant(of: sut.view))
    }
    
    func testHasLocationTF() {
        XCTAssertTrue(sut.locationTF.isDescendant(of: sut.view))
    }
    
    func testHasDateTF() {
        XCTAssertTrue(sut.dateTF.isDescendant(of: sut.view))
    }
    
    func testHasAddressTF() {
        XCTAssertTrue(sut.addressTF.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTF() {
        XCTAssertTrue(sut.descriptionTF.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConvertCoordinateFromAddress() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "01.01.19")
        
        sut.titleTF.text = "Foo"
        sut.locationTF.text = "Bar"
        sut.dateTF.text = "01.01.19"
        sut.addressTF.text = "Ярославль"
        sut.descriptionTF.text = "Baz"
        sut.taskManager = TaskManager()
        
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.save()
        
        
        let coordinate = CLLocationCoordinate2D(latitude: 57.6255756, longitude: 39.8913949)
        let location = Location(name: "Bar", coordinate: coordinate)
        
        let generatedTask = Task(title: "Foo", description: "Baz", location: location, date: date)
        
        placemark = MockClPlacemark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager?.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
}

extension NewTaskVCTests {
    
    class MockCLGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockClPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}
