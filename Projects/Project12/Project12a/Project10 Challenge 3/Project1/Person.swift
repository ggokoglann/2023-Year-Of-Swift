//
//  Person.swift
//  Project1
//
//  Created by Gökhan Gökoğlan on 7.03.2023.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
        
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
