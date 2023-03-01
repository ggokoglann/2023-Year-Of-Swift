//
//  ViewController.swift
//  Project7
//
//  Created by Gökhan Gökoğlan on 17.01.2023.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredList = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let creditsButton = UIBarButtonItem(title: "Credits", style: .done, target: self, action: #selector(creditsButton))
        let filterButton = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(filterButton))
        
        navigationItem.leftBarButtonItem = filterButton
        navigationItem.rightBarButtonItem = creditsButton
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was an error while loading the page please check your internet connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredList = petitions
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredList[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func creditsButton() {
        let ac = UIAlertController(title: "Credits", message: "This data comes from Whitehouse Petitions", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        ac.addAction(okButton)
        present(ac, animated: true)
    }
        
    @objc func filterButton() {
            let ac = UIAlertController(title: "Filter", message: "Please enter a string to filter by.", preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                    if let filterString = ac.textFields?.first?.text?.trimmingCharacters(in: .whitespaces) {
                        guard let self = self else { return }
                        DispatchQueue.global().async {
                            self.filteredList = self.petitions.filter { petition in
                                petition.title.localizedCaseInsensitiveContains(filterString)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            )
            present(ac, animated: true)
    }
} 

