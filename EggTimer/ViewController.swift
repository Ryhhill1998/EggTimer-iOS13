//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var eggTimer: Timer?
    
    let eggTimes = [
        "Soft": 300,
        "Medium": 420,
        "Hard": 720
    ]
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        eggTimer?.invalidate()
        
        guard let hardness = sender.currentTitle else
        {
            return
        }
        
        guard let timer = eggTimes[hardness] else { return }
        
        runTimer(seconds: timer)
    }
    
    func runTimer(seconds: Int) {
        var secondsRemaining = seconds
        
        eggTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            secondsRemaining -= 1
            print(secondsRemaining)
            
            if secondsRemaining == 0 {
                timer.invalidate()
                self.titleLabel.text = "Done"
            }
        }
    }
}
