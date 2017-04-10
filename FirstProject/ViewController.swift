//
//  ViewController.swift
//  FirstProject
//
//  Created by LinuxPlus on 4/8/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    
    var totalScore: Int = 0
    var roundScore: Int = 0
    var round: Int = 0
    var currentValue: Int = 0
    var targetValue: Int = 0
    var message: String = ""
    var lock: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startnewRound()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startnewRound(){
        lock = true
        targetValue = 1 + Int(arc4random_uniform(100))
        targetLabel.text = String(targetValue)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        roundLabel.text = String(round)

    }
    
    @IBAction func finishGame(){
        if(lock){
        currentValue = lroundf(slider.value)
        roundScore = calculateScore(currentValue)
        totalScore += roundScore
        scoreLabel.text = String(totalScore)
        let alert = showAlert("\(message)", "You scored \(roundScore) \n Your value is: \(currentValue) \n Your target is: \(targetValue)", "OK" )
        present(alert, animated: true, completion: nil)
        lock = false
        }else{
            let alert = showAlert("Tip!", "Press start over (Button) for new round!", "OK" )
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func startOver(){
        startnewRound()
    }
    
    @IBAction func showInfo(){
        let alert: UIAlertController = showAlert("App info!", "You should move the slider to the target point!", "Got it!")
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetView(){
        totalScore = 0
        round = 0
        scoreLabel.text = String(totalScore)
        roundLabel.text = String(round)
        startnewRound()
    }

    func showAlert(_ alertTitle: String, _ alertMessage: String, _ actionName: String) -> UIAlertController {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionName, style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    
    func calculateScore(_ score: Int) -> Int {
        let difference = Swift.abs(targetValue - score)
        var myScore = 100 - difference
        if(difference == 0){
            message = "Perfect!"
            myScore += 100
        }else if (difference < 5){
            message = "You almost had it!"
            myScore += 50
            
        }else if (difference < 10){
            message = "Prety good!"
        }else{
            message = "Not even close to it!"
        }
        return myScore
    }
}

