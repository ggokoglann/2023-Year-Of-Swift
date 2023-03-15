//
//  DetailViewController.swift
//  Milestone Project 10-12
//
//  Created by Gökhan Gökoğlan on 15.03.2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           if let imageToLoad = selectedImage {
               imageView.image = UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(imageToLoad).path)
           }
       }
       
       func getDocumentsDirectory() -> URL {
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           return paths[0]
       }
   }
