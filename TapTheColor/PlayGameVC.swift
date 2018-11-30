//
//  GameVC.swift
//  TapTheColor
//
//  Created by Justin Lewis on 10/9/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import UIKit

class PlayGameVC: UIViewController, gameDelegate {

    //MARK: - IBOutlets
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var timeScoreLabel: UILabel!
    
    //MARK: - Instance Variables
    ///The possible color choices
    private let colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]

    ///The game model object
    private let game = StroopGame()

    //MARK: - Overrides
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        game.myDelegate = self
        game.highScore = UserDefaults.standard.integer(forKey: "highScore")
        game.timeRemaining = game.maxGameTime
        timeScoreLabel.text = "Time: \(game.timeRemaining)"
    }

    //MARK: - IBActions
    //Picking Buttons
    
    @IBAction func userTappedAColorButton(_ sender: UIButton) {
        game.playGame(playerChoice: sender.tag)

        updateLabels()

    }

    //MARK: - My Functions

    private func updateLabels () {
        colorLabel.text = game.wordToDisplay
        colorLabel.textColor = colors[game.correctAnswer]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameOverVC {
            vc.score = game.score
            vc.highScore = game.highScore
            vc.isNewHighScore = game.achievedNewHighScore
        }
    }
    
    //MARK: - Delegate Methods
    func updateTimerDisplay (with timeRemaining: Int) {
        self.timeScoreLabel.text = "Time: \(timeRemaining)"
    }
    
    func endGame() {
        performSegue(withIdentifier: "GoToGameOver", sender: nil)
        timeScoreLabel.text = "Time: \(game.timeRemaining)"
        colorLabel.text = "START"
        colorLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
}

