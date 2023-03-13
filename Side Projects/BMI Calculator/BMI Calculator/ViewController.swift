//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Gökhan Gökoğlan on 13.03.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet var calculate: UIButton!
    @IBOutlet var result: UILabel!
    
    var heightInput: Int?
    var weigthInput: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        height.delegate = self
        weight.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            if textField == height {
                if let input = textField.text, let number = Int(input) {
                    heightInput = number
                } else {
                    heightInput = nil
                }
                weight.becomeFirstResponder()
            } else if textField == weight {
                if let input = textField.text, let number = Int(input) {
                    weigthInput = number
                } else {
                    weigthInput = nil
                }
            }
            return true
        }
    
    @IBAction func calculateBegin(_ sender: UIButton) {
        if let heightInput = height.text, let weigthInput = weight.text,
               let height = Float(heightInput), let weight = Float(weigthInput) {
                
                let bmi1 = 10000 * (weight / (height * height))            
            
                let bmiString = String(format: "%.2f", bmi1)
                let bmiPrefix = bmiString.prefix(4)
            
                result.text = "Your Bmi: \(bmiPrefix)"
                
                } else {
            print("Please enter valid values for height and weight.")
        }
    }
}

