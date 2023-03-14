//
//  ViewController.swift
//  Project5
//
//  Created by Gökhan Gökoğlan on 11.01.2023.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    var currentWord: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["Gokhan"]
        }
        
        startGame()
    }
        func startGame() {
            let defaults = UserDefaults.standard
            
            currentWord = allWords.randomElement()!
            title = currentWord
            defaults.set(currentWord, forKey: "CurrentWord")
            
            usedWords.removeAll(keepingCapacity: true)
            defaults.set(usedWords, forKey: "UsedWords")
            
            tableView.reloadData()
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func restartGame() {
        startGame()
        }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if isLonger(word: lowerAnswer) {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        usedWords.insert(answer, at: 0)
                        
                        let defaults = UserDefaults.standard
                        defaults.set(usedWords, forKey: "UsedWords")
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    } else {
                        showErrorMessage(errorMessage: "You can't just make them up", errorTitle: "Word is not real")
                    }
                } else {
                    showErrorMessage(errorMessage: "Be more original!", errorTitle: "Word used already")
                }
            } else {
                guard let title = title?.lowercased() else { return }
                showErrorMessage(errorMessage: "You can't spell that word from \(title)", errorTitle: "Word not possible")
            }
        } else {
            showErrorMessage(errorMessage: "Word must be longer than 3 letters", errorTitle: "Short Word")
        }
        
       
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
        
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isLonger(word: String) -> Bool {
        let letterCount = word.count
        if letterCount > 3 {
            return true
        } else {
            return false
        }
    }
    
    func showErrorMessage(errorMessage: String, errorTitle: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

