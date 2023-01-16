//
//  ViewController.swift
//  Shopping List
//
//  Created by Gökhan Gökoğlan on 16.01.2023.
//

import UIKit

class ViewController: UITableViewController {
    var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Alışveriş Listesi"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reList))
    }
    
    func resetList() {
        list.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppinglist", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func addToList(_ item: String) {
        list.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Alınacak", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addingAction = UIAlertAction(title: "Ekle", style: .default) { [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.addToList(item)
        }
        ac.addAction(addingAction)
        present(ac, animated: true)
    }
    
    @objc func reList() {
        resetList()
    }
}
    
    


