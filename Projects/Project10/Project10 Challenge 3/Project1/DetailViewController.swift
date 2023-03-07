//
//  DetailViewController.swift
//  Project1
//
//  Created by Gökhan Gökoğlan on 20.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var totalPictures = 0
    var pictureSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(pictureSelected) of \(totalPictures)"
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
