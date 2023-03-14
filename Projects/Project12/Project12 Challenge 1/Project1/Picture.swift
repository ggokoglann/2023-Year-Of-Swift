//
//  Picture.swift
//  Project1
//
//  Created by Gökhan Gökoğlan on 14.03.2023.
//

import UIKit

class Picture: NSObject {
    var name: String
    var image: String
    var subtitle: String
    var views: Int {
        didSet {
            subtitle = "Views: \(views)"
        }
    }
    
    init(name: String, image: String, subtitle: String, views: Int) {
        self.name = name
        self.image = image
        self.subtitle = subtitle
        self.views = views
    }
}
