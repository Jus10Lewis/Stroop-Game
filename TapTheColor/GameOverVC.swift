//
//  GameOverVC.swift
//  TapTheColor
//
//  Created by Justin Lewis on 10/26/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import UIKit

class GameOverVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var newHighLabel: UILabel!

    //MARK: - Instance Variables
    var score = 0
    var isNewHighScore = false
    

    ///colors used to blink a label
    private let blinkColors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]

    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        scoreLabel.text = "Score: \(score)"
        highScoreLabel.text = "High Score: \(highScore)"
        if isNewHighScore {
            newHighLabel.isHidden = false
            playSound("fonfar")
            blinkTheNewHighLabel()
        } else {
            newHighLabel.isHidden = true
        }
    }
    
    //MARK: - IBActions
    @IBAction func playAgain (){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - My Functions
    private func blinkTheNewHighLabel() {
        var colorCounter = 0
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            colorCounter += 1
            colorCounter %= self.blinkColors.count
            self.newHighLabel.textColor = self.blinkColors[colorCounter]
        }
    }
}

