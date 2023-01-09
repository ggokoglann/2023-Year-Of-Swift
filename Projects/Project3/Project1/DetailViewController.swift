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
    var selectedImageIndex: Int?
    var totalImage: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pictures \(String(describing: selectedImageIndex!)) of \(String(describing: totalImage!))"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }

        guard let imageName = selectedImage else {
                    print("No image name found...")
                    return
                }
                
                let vc = UIActivityViewController(
                    activityItems: [imageData, imageName],
                    applicationActivities: []
                )
                
                vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                
                present(vc, animated: true)
            }
        }
