//
//  StroopGame.swift
//  TapTheColor
//
//  Created by Justin Lewis on 10/29/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import Foundation


class StroopGame {
    
    var clockIsRunning = false
    var achievedNewHighScore = false
    
    var highScore = 0
    var score = 0
    let maxGameTime = 6
    var timeRemaining = 0
    ///The correct choice is an Int from 0 to 3
    var correctAnswer = 0
    
    var wordToDisplay = "START"
    var words = ["RED","BLUE","GREEN","YELLOW"]

    ///These two vars are hacky to avoid using delegation
    var clockShouldBeRunning = false
    var gameIsOver = false

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
            clockShouldBeRunning = true
            rollRandomAnswer()
            rollRandomWord()
            
        } else if clockIsRunning && !choiceIsCorrect {  //Playing game & WRONG choice
            endGame()
        } // ELSE game hasn't started yet & player clicked wrong button
        //Then do nothing
    }

    ///Picks a random word from the words array
    func rollRandomWord () {
        let wordNum = Int.random(in: 0...3)
        wordToDisplay = words[wordNum]
    }
    
    ///correctAnswer is a random integer representing one of the 4 color options
    func rollRandomAnswer() {
        correctAnswer = Int.random(in: 0...3)
    }
    
    //The VC needs to set this flag when it starts the game clock
    ///setClockIsRunning will be removed after timer moves to model
    //TODO: Move the Timer to the Game model after teaching delegation
    func setClockIsRunning () {
        clockIsRunning = true
    }
    
    ///tickTheGameClock will be removed after timer moves to model
    func tickTheGameClock() {
        timeRemaining -= 1
        if timeRemaining <= 0 {
            endGame()
        }
    }
    
    func setNewHighScore() {
        if score > highScore {
            highScore = score
            achievedNewHighScore = true
        } else {
            achievedNewHighScore = false
        }
    }

    //endGame called when timeRemaining <= 0
    //            or when player answer is wrong
    func endGame() {
        gameIsOver = true
        setNewHighScore()
        clockIsRunning = false
        clockShouldBeRunning = false
    }
    
    //Called when VC segues
    func resetGame() {
        gameIsOver = false
        score = 0
        correctAnswer = 0
        wordToDisplay = "START"
        timeRemaining = maxGameTime
    }
}
