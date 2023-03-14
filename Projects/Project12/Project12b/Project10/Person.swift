//
//  Person.swift
//  Project10
//
//  Created by Gökhan Gökoğlan on 1.03.2023.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}
