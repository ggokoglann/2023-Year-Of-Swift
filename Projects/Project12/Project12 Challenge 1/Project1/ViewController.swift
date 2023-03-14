//
//  ViewController.swift
//  Project1
//
//  Created by Gökhan Gökoğlan on 19.12.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        performSelector(inBackground: #selector(loadImages), with: nil)
        
    }
    
    @objc func loadImages () {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load!
                let picture = Picture(name: item, image: item, subtitle: "Views: 0", views: 0)
                pictures.append(picture)
            }
        }
        
        collectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue a PictureCell.")
        }
        let picture = pictures[indexPath.item]
        cell.name.text = picture.name
        cell.imageView.image = UIImage(named: picture.image)
        cell.subtitle.text = picture.subtitle
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item].image
            vc.selectedImageNumber = indexPath.item + 1
            vc.totalImages = pictures.count
            pictures[indexPath.item].views += 1
            collectionView.reloadItems(at: [indexPath])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let message = "You should try this app, it's great!"
        
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
        // Needed for iPad, to show where the popover is called from
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}





 
