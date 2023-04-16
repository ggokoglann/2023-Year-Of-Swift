//
//  CountryDetailViewControllerTableViewController.swift
//  Milestone Project 13-15
//
//  Created by Gökhan Gökoğlan on 16.04.2023.
//

import UIKit

class CountryDetailViewController: UITableViewController {
    
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // You can change this number to match the number of facts you want to show
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Capital: \(country?.capital ?? "-")"
        case 1:
            cell.textLabel?.text = "Size: \(country?.size ?? 0) sq. km"
        case 2:
            cell.textLabel?.text = "Population: \(country?.population ?? 0)"
        case 3:
            cell.textLabel?.text = "Currency: \(country?.currency ?? "-")"
        case 4:
            cell.textLabel?.text = "Language: \(country?.language ?? "-")"
        default:
            cell.textLabel?.text = ""
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.selectionStyle = .none
        
        return cell
    }
    
}
