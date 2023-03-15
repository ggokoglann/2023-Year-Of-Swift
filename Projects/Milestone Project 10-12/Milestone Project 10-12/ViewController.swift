//
//  ViewController.swift
//  Milestone Project 10-12
//
//  Created by Gökhan Gökoğlan on 15.03.2023.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Photo Library"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPhoto))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photo", for: indexPath) as? PhotoCell else {
            fatalError("Cannot deque a cell")
        }
        
        let photo = photos[indexPath.item]
        cell.caption.text = photo.caption
                                      
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let photo = photos[indexPath.item]
            vc.selectedImage = photo.imageName
            navigationController?.pushViewController(vc, animated: true)
        }
        print(photos)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectiory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true) {
            let ac = UIAlertController(title: "Add Caption", message: "Enter a caption for the photo", preferredStyle: .alert)
            ac.addTextField { textField in
                textField.placeholder = "Caption"
            }
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
                guard let caption = ac?.textFields?[0].text else { return }
                let photo = Photo(caption: caption, imageName: imageName)
                self?.photos.append(photo)
                self?.tableView.reloadData()
            })
            
            self.present(ac, animated: true)
        }
    }
    
    func getDocumentsDirectiory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
       
    @objc func addNewPhoto() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
                                
    }       
}

