//
//  ViewController.swift
//  PokerDice
//
//  Created by Anton Romanov on 01/12/2017.
//  Copyright © 2017 Anton Romanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Declare variables and outlets
    
    @IBOutlet var playerDices: [UIButton]!
    @IBOutlet var casinoDices: [UIButton]!
    @IBOutlet weak var customBetInput: UITextField!
    @IBOutlet weak var bankAmount: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var playersMoney: UILabel!
    @IBOutlet weak var currentRound: UILabel!
    
    //Declare variables for computing combinations.
    
    var casinoHandArray = [Int](repeatElement(0, count: 5))
    var playerHandArray = [Int](repeatElement(0, count: 5))
    var gameStep = "beforeStart"
    var bankSum = 0
    var playersSum = 0
    var customBet = 0
    var playerName = ""
    var otherBetButtonWasPressed = false
    var diceToBeChanged = [Int](repeatElement(0, count: 5))
    var rollDiceCanBePressed = false
    var rollCounter = 0
    var randomDice = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        randomCasinoThrowAllDices()
        randomPlayerThrowAllDices()
        playersMoney.text = "Player's money: \(playersSum)$"
        bankAmount.text = "Bank: \(bankSum)$"
        currentRound.text = ""
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Setting player name with Alert. Game will not start before setting name.
    @IBAction func setPlayerName(_ sender: UIButton) {
        if gameStep == "beforeStart" {
            let alert = UIAlertController(title: "Greetings!", message: "Please input your name and you will get 200$.", preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Your name"
            }
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (UIAlertAction) in
                let textField = alert.textFields![0]
                sender.setTitle(textField.text, for: .normal)
                self.playerName = textField.text!
                
            }))
            self.present(alert, animated: true, completion: nil)
            
            gameDescription.text = "Round 1: Make your Bet (press '10' or '20' or '40' or type custom bet and press 'CustomBet') and after that Roll dices."
            
            gameStep = "Round 1"
            currentRound.text = gameStep
            playersSum = 200
            playersMoney.text = "Player's money: \(playersSum)$"
        }
    }
    
    //makeBEt function
    @IBAction func makeBet(_ sender: UIButton) {
        
        //check if '10' betButton was pressed.
        
        if sender.tag == 11 && (playersSum - 10 > 0) && !(otherBetButtonWasPressed) {
            bankSum += 20
            playersSum -= 10
            playersMoney.text = "Player's money: \(playersSum)$"
            bankAmount.text = "Bank: \(bankSum)$"
            otherBetButtonWasPressed = true
            rollDiceCanBePressed = true
            
        }
        
        //check if '20' betButton was pressed.
        
        if sender.tag == 12 && (playersSum - 20 > 0) && !(otherBetButtonWasPressed) {
            bankSum += 40
            playersSum -= 20
            playersMoney.text = "Player's money: \(playersSum)$"
            bankAmount.text = "Bank: \(bankSum)$"
            otherBetButtonWasPressed = true
            rollDiceCanBePressed = true
            
        }
        //check if '40' betButton was pressed.
        
        if sender.tag == 13 && (playersSum - 40 > 0) && !(otherBetButtonWasPressed) {
            bankSum += 80
            playersSum -= 40
            playersMoney.text = "Player's money: \(playersSum)$"
            bankAmount.text = "Bank: \(bankSum)$"
            otherBetButtonWasPressed = true
            rollDiceCanBePressed = true
            
        }
        
        //check if CustomBet was made
        
        if sender.tag == 14 {
            
            if isTypedIsInt(customBetInput.text!) && !(otherBetButtonWasPressed) {
                customBet = Int(customBetInput.text!)!
                if customBet >= 0 && customBet <= 500 && (playersSum - customBet) >= 0 {
            
                    bankSum += 2 * customBet
                    playersSum -= customBet
                    playersMoney.text = "Player's money: \(playersSum)$"
                    bankAmount.text = "Bank: \(bankSum)$"
                    otherBetButtonWasPressed = true
                    rollDiceCanBePressed = true
                    self.customBetInput.text = ""
                    
                } else if customBet < 0 || customBet > 500 || (playersSum - customBet) < 0 {
                    
                let alert = UIAlertController(title: "Warning!", message: "Please input only numbers from 0 to 500.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                    self.customBetInput.text = ""
                    
                }))
                self.present(alert, animated: true, completion: nil)
                    
                }
            }
            else {
                let alert = UIAlertController(title: "Warning!", message: "Please input only numbers from 0 to 500.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                    self.customBetInput.text = ""
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        
        }
        
    }
    
    //Functon describes touching dices to be changed
    @IBAction func changePlayerDice(_ sender: UIButton) {
        if gameStep == "Round 2" {
            if sender.tag == 6 {
                diceToBeChanged[0] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 7 {
                diceToBeChanged[1] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 8 {
                diceToBeChanged[2] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 9 {
                diceToBeChanged[3] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 10 {
                diceToBeChanged[4] = 1
                rollDiceCanBePressed = true
            }
        }
        if gameStep == "Round 3" {
            if sender.tag == 6 {
                diceToBeChanged[0] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 7 {
                diceToBeChanged[1] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 8 {
                diceToBeChanged[2] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 9 {
                diceToBeChanged[3] = 1
                rollDiceCanBePressed = true
            }
            if sender.tag == 10 {
                diceToBeChanged[4] = 1
                rollDiceCanBePressed = true
            }
        }
        
    }
    // Function describes what to do if player wants to keep dices
    
    @IBAction func keepDices(_ sender: UIButton) {
        if gameStep == "Round 2" && rollCounter == 1 {
            // If casino has weaker hand than Player, so Casino changes all dices, after PLAYER CHOSE WHAT DICES TO CHANGE but not changed yet.
            if winner(casino: casinoHandArray, player: playerHandArray) == "\(playerName) wins" {
                casinoChangesDices()
            }
            
            gameDescription.text = "Casino has: \(handDescription(casinoHandArray)). \n \(playerName) has: \(handDescription(playerHandArray)). \n \(winner(casino: casinoHandArray, player: playerHandArray)) in \(gameStep). Please press 'Next round'"
            rollCounter += 1
            otherBetButtonWasPressed = true
        }
        
        if gameStep == "Round 3" && rollCounter == 2{
            // If casino has weaker hand than Player, so Casino changes all dices, after PLAYER CHOSE WHAT DICES TO CHANGE but not changed yet.
            if winner(casino: casinoHandArray, player: playerHandArray) == "\(playerName) wins" {
                casinoChangesDices()
            }

            gameDescription.text = "Casino has: \(handDescription(casinoHandArray)). \n \(playerName) has: \(handDescription(playerHandArray)). \n \(winner(casino: casinoHandArray, player: playerHandArray)) in \(gameStep). \n\n \(winner(casino: casinoHandArray, player: playerHandArray))."
            rollCounter += 1
            gameStep = "Final"
            currentRound.text = gameStep
            otherBetButtonWasPressed = true
            
            //to whom goes money?
            if winner(casino: casinoHandArray, player: playerHandArray) == "Casino wins" {
                bankAmount.text = "Bank: Casino takes \(bankSum)."
                bankSum = 0
                
            }
            if winner(casino: casinoHandArray, player: playerHandArray) == "\(playerName) wins" {
                playersSum += bankSum
                bankSum = 0
                playersMoney.text = "Player's money: \(playersSum)$"
                bankAmount.text = "Bank: \(bankSum)$"
            }
            if winner(casino: casinoHandArray, player: playerHandArray) == "Draw" {
                playersSum += bankSum / 2
                bankSum = bankSum / 2
                playersMoney.text = "Player's money: \(playersSum)$"
                bankAmount.text = "Bank: Casino takes \(bankSum)$"
            }
        }
        
    }
    
    @IBAction func nextRound(_ sender: Any) {
        if rollCounter == 1 && gameStep == "Round 1" {
            
            let alert = UIAlertController(title: "\(gameStep) ended.", message: "1. Touch dice(s) you want to change(you may keep dices) \n 2. Make a bet or not. \n 3. Press 'Roll' if you need to change dices, 'Keep dices' if you don't want to change.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                self.customBetInput.text = ""
                
            }))
            self.present(alert, animated: true, completion: nil)
            otherBetButtonWasPressed = false
            gameStep = "Round 2"
            currentRound.text = gameStep
            gameDescription.text = "Casino has: \(handDescription(casinoHandArray)).\n \(playerName) has: \(handDescription(playerHandArray)). \n\n Make bet or not. Choose dice(s) to change or not. Press 'Roll' or 'Keep dices'."
        }
        
        if rollCounter == 2 && gameStep == "Round 2" {
            otherBetButtonWasPressed = false
            gameStep = "Round 3"
            currentRound.text = gameStep
            diceToBeChanged = [0, 0, 0, 0 ,0]
            gameDescription.text = "Casino has: \(handDescription(casinoHandArray)).\n \(playerName) has: \(handDescription(playerHandArray)). \n\n Make bet or not. Choose dice(s) to change or not. Press 'Roll' or 'Keep dices'."
            
        }
        
        if rollCounter == 3 && gameStep == "Final" {
            
            let alert = UIAlertController(title: "Give it a try!", message: "Would you like to play more?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play again.", style: .default, handler: { (UIAlertAction) in
                self.startOver()
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func rollDices(_ sender: UIButton) {
        if rollDiceCanBePressed {
            
        //In Round 1 Casino and Player got all 5 random dices
        if gameStep == "Round 1" && rollCounter == 0 {
            randomCasinoThrowAllDices()
            randomPlayerThrowAllDices()
            gameDescription.text = "Casino has: \(handDescription(casinoHandArray)). \n \(playerName) has: \(handDescription(playerHandArray)). \n \(winner(casino: casinoHandArray, player: playerHandArray)) in \(gameStep). Please press 'Next round'"
            rollCounter += 1
            }
        }
        
        if gameStep == "Round 2" && rollCounter == 1
        {
            if diceToBeChanged == [0, 0, 0, 0, 0] {
                gameDescription.text = "If you don't want to change dices, please press 'Keep dices'"
            } else {
                // If casino has weaker hand than Player, so Casino changes all dices, after PLAYER CHOSE WHAT DICES TO CHANGE but not changed yet.
                if winner(casino: casinoHandArray, player: playerHandArray) == "\(playerName) wins" {
                    casinoChangesDices()
                }
                
            for i in 0...4 {
                
                if diceToBeChanged[i] == 1 {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    playerHandArray[i] = randomDice
                    playerDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }
            gameDescription.text = "Casino has: \(handDescription(casinoHandArray)). \n \(playerName) has: \(handDescription(playerHandArray)). \n \(winner(casino: casinoHandArray, player: playerHandArray)) in \(gameStep). Please press 'Next round'"
            rollCounter += 1
            otherBetButtonWasPressed = true
            }
            
        }
        
        if gameStep == "Round 3" && rollCounter == 2
        {
            if diceToBeChanged == [0, 0, 0, 0, 0] {
                gameDescription.text = "If you don't want to change dices, please press 'Keep dices'"
            } else {
                // If casino has weaker hand than Player, so Casino changes all dices, after PLAYER CHOSE WHAT DICES TO CHANGE but not changed yet.
                if winner(casino: casinoHandArray, player: playerHandArray) == "\(playerName) wins" {
                    casinoChangesDices()
                }
                
                for i in 0...4 {
                    
                    if diceToBeChanged[i] == 1 {
                        randomDice = Int(arc4random_uniform(6)) + 1
                        playerHandArray[i] = randomDice
                        playerDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                    }
                }
                gameDescription.text = "Casino has: \(handDescription(casinoHandArray)). \n \(playerName) has: \(handDescription(playerHandArray)). \n \(winner(casino: casinoHandArray, player: playerHandArray)) in \(gameStep). \n\n \(winner(casino: casinoHandArray, player: playerHandArray))."
                rollCounter += 1
                gameStep = "Final"
                currentRound.text = gameStep
                otherBetButtonWasPressed = true
                
                //to whom goes money?
                if winner(casino: casinoHandArray, player: playerHandArray) == "Casino wins" {
                    bankAmount.text = "Casino takes \(bankSum)!"
                    bankSum = 0
                    
                }
                if winner(casino: casinoHandArray, player: playerHandArray) == "\(playerName) wins" {
                    playersSum += bankSum
                    bankSum = 0
                    playersMoney.text = "Player's money: \(playersSum)$"
                    bankAmount.text = "Bank: \(bankSum)$"
                }
                if winner(casino: casinoHandArray, player: playerHandArray) == "Draw" {
                    playersSum += bankSum / 2
                    bankSum = bankSum / 2
                    playersMoney.text = "Player's money: \(playersSum)$"
                    bankAmount.text = "Bank: Casino takes \(bankSum)$"
                }
            }
            
        }
        rollDiceCanBePressed = false
    }
    
    
    // declaring throw dices function for casino.
    func randomCasinoThrowAllDices() {
        for i in 0...4 {
            randomDice = Int(arc4random_uniform(6)) + 1
            casinoHandArray[i] = randomDice
            casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
        }
        
    }
    
    // declaring throw dices for a player.
    func randomPlayerThrowAllDices() {
        for i in 0...4 {
            randomDice = Int(arc4random_uniform(6)) + 1
            playerHandArray[i] = randomDice
            playerDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
        }
        
    }
    
    // declaring function wich checks validity of Int typed in textBox
    func isTypedIsInt(_ string: String) -> Bool {
        
        if let _ = Int(string) {
            return true
        }
        return false

    }
    //Function to manage what dices to be changed by Casino
    func casinoChangesDices() {
        
        // Change all 5 dices if player leads with higher  FIVE OF A KIND
        
        if currentHandStrength(casinoHandArray) == 8 {
            randomCasinoThrowAllDices()

        // Change only one dice if Player leads with higher than Four of a kind
            
        } else if currentHandStrength(casinoHandArray) == 7 {
            for i in 0...4 {
                if casinoHandArray[i] != fourOfAKind(casinoHandArray).hand {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    casinoHandArray[i] = randomDice
                    casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }

         //Change only two lower dice from full house
        } else if currentHandStrength(casinoHandArray) == 6 {
            for i in 0...4 {
                if casinoHandArray[i] != fullHouse(casinoHandArray).houseHigh {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    casinoHandArray[i] = randomDice
                    casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }
            
        // Change four dices if straight, except the high dice
        } else if currentHandStrength(casinoHandArray) == 5 {
            for i in 0...4 {
                if casinoHandArray[i] != straight(casinoHandArray).straightHigh {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    casinoHandArray[i] = randomDice
                    casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }
        // Change 2 dices except Three of a kind
        } else if currentHandStrength(casinoHandArray) == 4 {
            for i in 0...4 {
                if casinoHandArray[i] != threeOfAKind(casinoHandArray).hand {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    casinoHandArray[i] = randomDice
                    casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }
            
        // Change low pair and low dic. Keep High pair.
        } else if currentHandStrength(casinoHandArray) == 3 {
            for i in 0...4 {
                if casinoHandArray[i] != twoPairs(casinoHandArray).highPair {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    casinoHandArray[i] = randomDice
                    casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }
            
         // Change 3 dices except the pair
        } else if currentHandStrength(casinoHandArray) == 2 {
            for i in 0...4 {
                if casinoHandArray[i] != onePair(casinoHandArray).pairOf {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    casinoHandArray[i] = randomDice
                    casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }
            
         // Change 4 dices except high dice
        } else if currentHandStrength(casinoHandArray) == 1 {
            for i in 0...4 {
                if casinoHandArray[i] != highCard(casinoHandArray).highCard {
                    randomDice = Int(arc4random_uniform(6)) + 1
                    casinoHandArray[i] = randomDice
                    casinoDices[i].setBackgroundImage(UIImage(named: "dice\(randomDice)"), for: .normal)
                }
            }
        }
    }
    
    
    //start over function
    func startOver() {
        
        gameDescription.text = "Round 1: Make your Bet (press '10' or '20' or '40' or type custom bet and press 'CustomBet') and after that Roll dices."
        gameStep = "Round 1"
        currentRound.text = gameStep
        bankSum = 0
        customBet = 0
        diceToBeChanged = [0, 0, 0, 0, 0]
        rollDiceCanBePressed = false
        otherBetButtonWasPressed = false
        rollCounter = 0
        bankAmount.text = "Bank: \(bankSum)$"
    }
    
    
    // Analysing combinations
    
    //Five of a kind function
    
    func fiveOfAKind(_ handArray : [Int]) -> (hand: Int, handStrength: Int) {
        var counter = 0
        var strength = 0
        
        for i in 1...4 {
            if handArray[0] == handArray[i] {
                counter += 1
            }
        }
        
        if counter == 4 {
            strength = 8
        }
        return (handArray[0], strength)
    }
    
    //Four of a kind function
    func fourOfAKind(_ handArray : [Int]) -> (hand: Int, handStrength: Int) {
        var counter = 0
        var strength = 0
        var handPosition = 0
        
        for i in 0...3 {
            for k in (i+1)...4 {
                if handArray[i] == handArray [k] {
                    counter += 1
                    handPosition = i
                }
            }
        }
        
        if counter == 6 {
            strength = 7
        }
        
        return (handArray[handPosition], strength)
    }
    
    //FullHouse function
    func fullHouse(_ handArray : [Int]) -> (houseHigh: Int, houseLow: Int, handStrength: Int) {
        var counter = 0
        var handPosition = 0
        var strength = 0
        var handPositionLow = 0
        var handPositionHigh = 0
        
        for i in 1...4 {
            if handArray[0] == handArray[i] {
                counter += 1
                handPosition = i
            }
        }
        
        if counter == 1 {
            handPositionLow = handPosition
            counter = 0
            
            for i in 0...3 {
                for k in (i+1)...4 {
                    if handArray[i] != handArray[handPositionLow] && handArray[i] == handArray [k] {
                        counter += 1
                        handPositionHigh = i
                    }
                }
            }
            if counter == 3 {
                strength = 6
            }
            
        } else if counter == 2 {
            handPositionHigh = handPosition
            counter = 0
            
            for i in 0...3 {
                for k in (i+1)...4 {
                    if handArray[i] != handArray[handPositionHigh] && handArray[i] == handArray [k] {
                        counter += 1
                        handPositionLow = i
                    }
                }
            }
            if counter == 1 {
                strength = 6
            }
        }
        
        return (handArray[handPositionHigh], handArray[handPositionLow], strength)
    }
    
    //Straight Function
    func straight(_ handArray : [Int]) -> (straightLow: Int, straightHigh: Int, handStrength: Int) {
        var counter = 0
        var min = 0
        var max = 0
        var strength = 0
        
        for i in 0...4 {
            for k in 0...4 {
                
                if (handArray[i] == handArray[k] + 1) || (handArray[i] == handArray[k] - 1)
                {
                    counter += 1
                }
                if (handArray[i] == handArray[k]) && (i != k)
                {
                    counter -= 2
                }
            }
        }
        
        if counter == 8 {
            strength = 5
            min = handArray[0]
            max = handArray[0]
            
            for i in 0...4 {
                if min > handArray[i] { min = handArray[i] }
                if max < handArray[i] { max = handArray[i] }
            }
        }
        
        return (min, max, strength)
    }
    
    //ThreeOfAKind function
    func threeOfAKind(_ handArray : [Int]) -> (hand: Int, handStrength: Int) {
        var counter = 0
        var strength = 0
        var handPosition = 0
        
        for i in 0...3 {
            for k in (i+1)...4 {
                if handArray[i] == handArray [k] {
                    counter += 1
                    handPosition = i
                }
            }
        }
        
        if counter == 3 {
            strength = 4
        }
        
        return (handArray[handPosition], strength)
    }
    
    //TwoPair function
    func twoPairs(_ handArray : [Int]) -> (highPair: Int, lowPair: Int, handStrength: Int) {
        var counter = 0
        var strength = 0
        var firstPairPosition = 0
        var secondPairPosition = 0
        var high = 0
        var low = 0
        
        for i in 0...3 {
            for k in (i+1)...4 {
                if handArray[i] == handArray [k] {
                    counter += 1
                    if counter == 1 { firstPairPosition = k }
                    if counter == 2 { secondPairPosition = k }
                }
            }
        }
        
        if handArray[firstPairPosition] > handArray[secondPairPosition] {
            high = handArray[firstPairPosition]
            low = handArray[secondPairPosition]
        } else {
            low = handArray[firstPairPosition]
            high = handArray[secondPairPosition]
        }
        
        if counter == 2 {
            strength = 3
        }
        
        return (high, low, strength)
    }
    
    //OnePair function
    func onePair(_ handArray : [Int]) -> (pairOf: Int, handStrength: Int) {
        var counter = 0
        var strength = 0
        var pair = 0
        
        for i in 0...3 {
            for k in (i+1)...4 {
                if handArray[i] == handArray[k] {
                    counter += 1
                    pair = handArray[i]
                }
            }
        }
        
        if counter == 1 {
            strength = 2
        }
        return (pair, strength)
    }
    
    //HighCard function
    func highCard(_ handArray : [Int]) -> (highCard: Int, handStrength: Int) {
        var counter = 0
        var strength = 0
        var max = handArray[0]
        
        for i in 1...4 {
            if handArray[0] == handArray[i] {
                counter += 1
            }
            if max < handArray[i] { max = handArray[i] }
        }
        
        if counter == 0 {
            strength = 1
        }
        return (max, strength)
    }
    
    // Current Hand Strength function
    
    func currentHandStrength(_ handArray: [Int]) -> Int {
        var currentHand = 0
        
        if fiveOfAKind(handArray).handStrength != 0 {
            currentHand = fiveOfAKind(handArray).handStrength
            
        } else if fourOfAKind(handArray).handStrength != 0 {
            currentHand = fourOfAKind(handArray).handStrength
            
        } else if fullHouse(handArray).handStrength != 0 {
            currentHand = fullHouse(handArray).handStrength
            
        } else if straight(handArray).handStrength != 0 {
            currentHand = straight(handArray).handStrength
            
        } else if threeOfAKind(handArray).handStrength != 0 {
            currentHand = threeOfAKind(handArray).handStrength
            
        } else if twoPairs(handArray).handStrength != 0 {
            currentHand = twoPairs(handArray).handStrength
            
        } else if onePair(handArray).handStrength != 0 {
            currentHand = onePair(handArray).handStrength
            
        } else if highCard(handArray).handStrength != 0 {
            currentHand = highCard(handArray).handStrength
            
        }
        return currentHand
    }
    
    //Hand description function
    
    func handDescription(_ handArray: [Int]) -> String {
        
        switch currentHandStrength(handArray) {
        case 8:
            return "Five of a \(fiveOfAKind(handArray).hand)."
        case 7:
            return "Four of a \(fourOfAKind(handArray).hand)"
        case 6:
            return "Full house of \(fullHouse(handArray).houseHigh) and \(fullHouse(handArray).houseLow)"
        case 5:
            return "Straight from \(straight(handArray).straightLow) to \(straight(handArray).straightHigh)"
        case 4:
            return "Three of \(threeOfAKind(handArray).hand)"
        case 3:
            return "Two pairs of \(twoPairs(handArray).highPair) and \(twoPairs(handArray).lowPair)"
        case 2:
            return "One Pair of \(onePair(handArray).pairOf)"
        default:
            return "High card is \(highCard(handArray).highCard)"
        }
    }
    
    // Winner function
    
    func winner(casino: [Int], player: [Int]) -> String {
        var description = ""
        var casinoSum = 0
        var playerSum = 0
        casinoSum = casino.reduce(0, +)
        playerSum = player.reduce(0, +)
        
        if currentHandStrength(casino) > currentHandStrength(player) {
            description = "Casino wins"
            
        } else if currentHandStrength(casino) < currentHandStrength(player) {
            description = "\(playerName) wins"
            
        } else if currentHandStrength(casino) == currentHandStrength(player) {
            
            if handDescription(casino) > handDescription(player) {
                description = "Casino wins"
                
            } else if handDescription(casino) < handDescription(player) {
                description = "\(playerName) wins"
                
            } else if handDescription(casino) == handDescription(player) && (casinoSum > playerSum) {
                description = "Casino wins"
                
            } else if handDescription(casino) == handDescription(player) && (casinoSum < playerSum) {
                description = "\(playerName) wins"
                
            } else if handDescription(casino) == handDescription(player) && casinoSum == playerSum {
                description = "Draw"
            }
            
        }
        return description
    }
    
}

