//
//  ViewController.swift
//  Project1
//
//  Created by Gökhan Gökoğlan on 19.12.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasSuffix(".png") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text =  pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            vc.selectedImage = pictures[indexPath.row]
            vc.totalImage = pictures.count
            vc.selectedImageIndex = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @objc func shareTapped() {
           var items: [Any] = ["This app is great, you should try it!"]
           if let url = URL(string: "https://www.hackingwithswift.com/100/16") {
               items.append(url)
           }
           
           let vc = UIActivityViewController(activityItems: items, applicationActivities: [])
           vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
           present(vc, animated: true)
       }
   }






 
