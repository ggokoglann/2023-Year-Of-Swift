//
//  Photo.swift
//  Milestone Project 10-12
//
//  Created by Gökhan Gökoğlan on 15.03.2023.
//

import UIKit

class Photo: NSObject {
    var caption: String
    var imageName: String
    
    init(caption: String, imageName: String) {
        self.caption = caption
        self.imageName = imageName
    }
}
