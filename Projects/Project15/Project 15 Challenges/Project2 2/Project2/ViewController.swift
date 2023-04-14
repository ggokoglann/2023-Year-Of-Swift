//
//  ViewController.swift
//  Project2
//
//  Created by Gökhan Gökoğlan on 24.12.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var askedQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreTapped))
        
        askQuestions()
    }

    func askQuestions(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        button1.transform = CGAffineTransform(scaleX: 1, y: 1)
        button2.transform = CGAffineTransform(scaleX: 1, y: 1)
        button3.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        title = "\(countries[correctAnswer].uppercased()) Score:\(score)"
        askedQuestions += 1
        if askedQuestions == 11 {
            let ac = UIAlertController(title: "Game Over!", message: "Your final score is \(score).", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestions))
            
            present(ac, animated: true)
            score = 0
            askedQuestions = 0
            
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var wrongAnswer = countries[sender.tag].uppercased()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5 , animations: { sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85) })
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong That's the flag of \(wrongAnswer)"
            score -= 1
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestions))
        
        present(ac, animated: true)
        
    }
    
    @objc func scoreTapped() {
          let ac = UIAlertController(title: "Score", message: String(score), preferredStyle: .alert)
          ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          present(ac, animated: true)
      }
}

