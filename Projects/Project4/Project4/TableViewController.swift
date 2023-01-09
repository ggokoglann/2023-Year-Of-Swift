//
//  TableViewController.swift
//  Project4
//
//  Created by Gökhan Gökoğlan on 9.01.2023.
//

import UIKit

class TableViewController: UITableViewController {
    let websites = [
        "udemy.com",
        "apple.com",
        "hackingwithswift.com",
        "github.com",
        "reddit.com",
        "youtube.com"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Easy Browser"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        
        cell.textLabel?.text = websites[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
            vc.websiteToLoad = websites[indexPath.row]
            vc.allowedWebsites = websites
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
