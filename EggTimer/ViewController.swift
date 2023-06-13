//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var eggTimer: Timer?
    var initialTimer = 0
    
    let eggTimes = [
        "Soft": 300,
        "Medium": 420,
        "Hard": 720
    ]
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        setProgress(progress: 0)
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        eggTimer?.invalidate()
        
        guard let hardness = sender.currentTitle else
        {
            return
        }
        
        titleLabel.text = hardness
        
        guard let timer = eggTimes[hardness] else { return }
        
        initialTimer = timer
        
        runTimer(seconds: timer)
    }
    
    func runTimer(seconds: Int) {
        var secondsRemaining = seconds
        
        eggTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            secondsRemaining -= 1
            self.updateProgress(secondsLeft: secondsRemaining)
            
            if secondsRemaining == 0 {
                timer.invalidate()
                self.titleLabel.text = "DONE!"
                self.playSound()
            }
        }
    }
    
    func updateProgress(secondsLeft: Int) {
        let secondsPassed = initialTimer - secondsLeft
        let completion: Float = Float(secondsPassed) / Float(initialTimer)
        setProgress(progress: completion)
    }
    
    func setProgress(progress: Float) {
        progressBar.progress = progress
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
