//
//  GameViewController.swift
//  TapTheColor
//
//  Created by Justin Lewis on 10/9/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var timeScoreLabel: UILabel!
    
    //MARK: - Instance Variables
    ///The possible color choices
    private let colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]

    ///The game model object
    private let game = StroopGame()

    private var gameTimer: Timer?

    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        game.timeRemaining = game.maxGameTime
        timeScoreLabel.text = "Time: \(game.timeRemaining)"
    }

    //MARK: - IBActions
    //Picking Buttons
    
    @IBAction func userTappedAColorButton(_ sender: UIButton) {
        game.playGame(playerChoice: sender.tag)
        if game.clockShouldBeRunning && !game.clockIsRunning {
            startTheClock() //Will be moved to StroopGame model
        }
        updateLabels()
        if game.gameIsOver {
            endGame()
        }
    }

    //MARK: - My Functions
    
    //TODO: Move to StroopGame model, and use a delegate method to set label text
    ///startTheClock will be moved to model soon
    private func startTheClock () {
        game.setClockIsRunning()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.game.tickTheGameClock()
            
            //This needs to stay in VC, and be called from model using delegation
            self.timeScoreLabel.text = "Time: \(self.game.timeRemaining)"
            
            if self.game.timeRemaining <= 0 {
                self.endGame()
            }
        }
    }
    
    private func endGame() {
        gameTimer?.invalidate()
        performSegue(withIdentifier: "GoToGameOver", sender: nil)
        game.resetGame()
        timeScoreLabel.text = "Time: \(game.timeRemaining)"
        colorLabel.text = "START"
        colorLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    private func updateLabels () {
        colorLabel.text = game.wordToDisplay
        colorLabel.textColor = colors[game.correctAnswer]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EndGameViewController {
            vc.score = game.score
            vc.highScore = game.highScore
            vc.isNewHighScore = game.achievedNewHighScore
        }
    }
}

