//
//  GameVC.swift
//  TapTheColor
//
//  Created by Justin Lewis on 10/9/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import UIKit

class PlayGameVC: UIViewController, gameDelegate {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var timeScoreLabel: UILabel!
    @IBOutlet var colorButtons: [UIButton]!
    
    ///The possible color choices
    private let colors = [#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]
    private let words = ["RED","BLUE","GREEN","YELLOW"]

    ///The game model object
    private var game: StroopGame?
    var gameTime = 10

    //MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        game = StroopGame(words: words, maxGameTime: gameTime)
//        game = StroopGame(words: words)
        if game == nil {
            fatalError("Couldn't initialize game model")
        }
        
        for (index, color) in colors.enumerated() {
            colorButtons[index].backgroundColor = color
            colorButtons[index].layer.cornerRadius = 20
            colorButtons[index].layer.borderWidth = 4
            colorButtons[index].layer.borderColor = UIColor.black.cgColor
        }
        game!.myDelegate = self
        game!.timeRemaining = game!.maxGameTime
        timeScoreLabel.text = "Time: \(game?.timeRemaining)"
    }

    override func viewWillAppear(_ animated: Bool) {
        timeScoreLabel.text = "Time: \(game!.timeRemaining)"
        colorLabel.text = "START"
        colorLabel.textColor = colors[0]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameOverVC {
            vc.score = game!.score
            vc.isNewHighScore = game!.achievedNewHighScore
        }
    }
    
    //MARK: - IBActions
    @IBAction func userTappedAColorButton(_ sender: UIButton) {
        game!.playGame(playerChoice: sender.tag)
        updateLabels()

    }

    @IBAction func backToMenu(_ sender: UIButton) {
        game!.stopTheClock()
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - My Functions
    private func updateLabels () {
        colorLabel.text = game!.wordToDisplay
        colorLabel.textColor = colors[game!.correctAnswer]
    }

    
    //MARK: - Delegate Methods
    func updateTimerDisplay (with timeRemaining: Int) {
        self.timeScoreLabel.text = "Time: \(timeRemaining)"
    }
    
    func endGame() {
        performSegue(withIdentifier: "GoToGameOver", sender: nil)
    }
}

