//
//  StroopGame.swift
//  TapTheColor
//
//  Created by Justin Lewis on 10/29/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import Foundation

protocol gameDelegate {
    func updateTimerDisplay (with timeRemaining: Int)
    func endGame()
}

class StroopGame {
    
    var myDelegate: gameDelegate?
    var clockIsRunning = false
    var achievedNewHighScore = false
    var highScore = 0
    var score = 0
    let maxGameTime = 6
    var timeRemaining = 0
    ///The correct choice is an Int from 0 to 3
    var correctAnswer = 0
    var previousAnswer = 0
    
    private var gameTimer: Timer?

    var wordToDisplay = "START"
    var previousWord = "START"
    private var words = ["RED","GREEN","BLUE","YELLOW"]

    //MARK: - Methods

    ///Play the game logic
    func playGame(playerChoice: Int) {
        //Compares the Integers of correctanswer and playerChoice
        let choiceIsCorrect = (playerChoice == correctAnswer)
        
        if clockIsRunning && choiceIsCorrect { //Playing game & CORRECT choice
            score += 1
            rollRandomAnswer()
            rollRandomWord()
        } else if !clockIsRunning && choiceIsCorrect { //Start the game
            startTheClock()
            rollRandomAnswer()
            rollRandomWord()
            
        } else if clockIsRunning && !choiceIsCorrect {  //Playing game & WRONG choice
            endGame()
        } // ELSE game hasn't started yet & player clicked wrong button
        //Then do nothing
    }


    private func startTheClock () {
        clockIsRunning = true
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in

            self.timeRemaining -= 1
            self.myDelegate?.updateTimerDisplay(with: self.timeRemaining)
            if self.timeRemaining <= 0 {
                self.endGame()
            }

        }
    }
    
    
    ///correctAnswer is a random integer representing one of the 4 color options
    private func rollRandomAnswer() {
        previousAnswer = correctAnswer
        while previousAnswer == correctAnswer {
            correctAnswer = Int.random(in: 0...3)
        }
    }
    
    ///Picks a random word from the words array
    private func rollRandomWord () {
        previousWord = wordToDisplay
        while previousWord == wordToDisplay {
            var wordNum = correctAnswer
            while wordNum == correctAnswer {
                wordNum = Int.random(in: 0...3)
            }
            wordToDisplay = words[wordNum]
        }
    }
    
    private func setNewHighScore() {
        if score > highScore {
            highScore = score
            achievedNewHighScore = true
            UserDefaults.standard.set(highScore, forKey: "highScore")
        } else {
            achievedNewHighScore = false
        }
    }

    //endGame called when timeRemaining <= 0
    //            or when player answer is wrong
    private func endGame() {
        setNewHighScore()
        myDelegate?.endGame()
        
        //reset the game
        clockIsRunning = false
        gameTimer?.invalidate()
        score = 0
        correctAnswer = 0
        wordToDisplay = "START"
        timeRemaining = maxGameTime
        myDelegate?.updateTimerDisplay(with: timeRemaining)
    }
}
