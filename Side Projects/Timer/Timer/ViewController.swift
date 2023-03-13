//
//  ViewController.swift
//  Timer
//
//  Created by Gökhan Gökoğlan on 4.03.2023.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet var TimerLabel: UILabel!
    @IBOutlet var StartStopButton: UIButton!
    @IBOutlet var ResetButton: UIButton!
    
    var timer: Timer?
    var startTime: Date?
    var elapsedTime: TimeInterval = 0.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerLabel.text = "00:00:00"
        StartStopButton.setTitle("Start", for: .normal)
        StartStopButton.tintColor = .green
        StartStopButton.setTitleColor(.black, for: .normal)
        ResetButton.setTitle("Reset", for: .normal)
        ResetButton.tintColor = .cyan
        ResetButton.setTitleColor(.black, for: .normal)
        
    }
    
    @IBAction func StartStopButtonPressed(_ sender: UIButton) {
        if timer == nil {
            // Start the timer
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            StartStopButton.setTitle("Stop", for: .normal)
            StartStopButton.tintColor = .red
            StartStopButton.setTitleColor(.white, for: .normal)
            startTime = Date()
        } else {
            // Stop the timer
            timer?.invalidate()
            timer = nil
            StartStopButton.setTitle("Start", for: .normal)
            StartStopButton.tintColor = .green
            StartStopButton.setTitleColor(.black, for: .normal)
            elapsedTime += Date().timeIntervalSince(startTime!)
        }
    }
    
    @IBAction func ResetButtonPressed(_ sender: Any) {
        // Reset the timer
        timer?.invalidate()
        timer = nil
        StartStopButton.setTitle("Start", for: .normal)
        StartStopButton.tintColor = .green
        StartStopButton.setTitleColor(.black, for: .normal)
        elapsedTime = 0.0
        TimerLabel.text = "00:00:00"        
    }
        
    @objc func updateTimer() {
        let currentTime = Date().timeIntervalSince(startTime!) + elapsedTime
        let minutes = Int(currentTime / 60)
        let seconds = Int(currentTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((currentTime.truncatingRemainder(dividingBy: 1)) * 100)
        TimerLabel.text = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
}
