//
//  Petition.swift
//  Project7
//
//  Created by Gökhan Gökoğlan on 17.01.2023.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
