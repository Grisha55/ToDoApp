//
//  APIClient.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 03/07/2022.
//

import Foundation

enum NetworkError: Error {
    case emptyData
    case serverError
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    func login(withName name: String, password: String, completionHandler: @escaping (String?, Error?) -> Void) {
        let allowedCharacters = CharacterSet.urlQueryAllowed
        
        guard let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
              let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "http://todoapp.com/login?\(query)") else {
            fatalError()
        }
        
        urlSession.dataTask(with: url) { (data, respone, error) in
            
            guard let data = data else {
                completionHandler(nil, NetworkError.emptyData)
                return
            }
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : String] else { return }
                
                let token = dictionary["token"]
                DispatchQueue.main.async {
                    completionHandler(token, nil)
                }
                
            } catch {
                print(error)
                completionHandler(nil, NetworkError.serverError)
            }

        }.resume()
    }
}
