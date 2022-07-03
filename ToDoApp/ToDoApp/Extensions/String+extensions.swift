//
//  Extensions.swift
//  ToDoApp
//
//  Created by Григорий Виняр on 03/07/2022.
//

import Foundation

extension String {
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "!,@£$%^&*(){}?").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        
        return encodedString
    }
}
