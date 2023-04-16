//
//  ViewController.swift
//  Milestone Project 13-15
//
//  Created by Gökhan Gökoğlan on 16.04.2023.
//

import UIKit

class CountriesViewController: UITableViewController {
    var countries: [Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            fatalError("Unable to find countries.json")
        }
        do {
            let jsonString = try String(contentsOf: url)
            guard let jsonData = jsonString.data(using: .utf8) else {
                fatalError("Unable to convert string to data")
            }
            let decoder = JSONDecoder()
            countries = try decoder.decode([Country].self, from: jsonData)
        } catch {
            fatalError("Unable to parse countries.json: \(error)")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.capital
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow,
           let detailViewController = segue.destination as? CountryDetailViewController {
            detailViewController.country = countries[indexPath.row]
        }
    }
}
