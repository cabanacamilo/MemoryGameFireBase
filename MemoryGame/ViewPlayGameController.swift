//
//  ViewPlayGameController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/3/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

var currentCounter = 1000

class ViewPlayGameController: UIViewController {
    
    var model = memoryModel()
    var choices = [Card]()
    
    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var flipsCount: UILabel!
    @IBOutlet var cardButton: [UIButton]!
    
    var flipCounter = 0
    
    var timer: Timer?
    var milliseconds: Float = 60 * 1000
    
    var soundManager = SoundManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        choices = model.getCards(cardsNumber: cardButton.count / 2)
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        soundManager.playSound(.shuffle)
    }
    
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        if milliseconds <= 0
        {
            return
        }
        if let cardNumber = cardButton.index(of: sender)
        {
            model.chooseCard(at: cardNumber)
            updateModel()
            endOfGame()
        }
    }
    
    func updateModel()
    {
        for index in cardButton.indices
        {
            let currentButton = cardButton[index]
            let currentCard = model.generateCards[index]
            if currentCard.flipped == true
            {
                currentButton.setTitle(currentCard.cards, for: UIControl.State.normal)
                currentButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                soundManager.playSound(.flip)
            }
            else
            {
                currentButton.setTitle("", for: UIControl.State.normal)
                currentButton.backgroundColor = currentCard.mached ? #colorLiteral(red: 0.9532852769, green: 0.8903858066, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            }
        }
    }
    
    func endOfGame()
    {
        var won = true
        var title = ""
        var message = ""
        for index in choices
        {
            if index.mached == false
            {
                won = false
                break
            }
        }
        if won == true
        {
            if milliseconds <= 0
            {
                timer?.invalidate()
            }
            
            if currentCounter > flipCounter
            {
                currentCounter = flipCounter
                let userID = Auth.auth().currentUser?.uid
                Database.database().reference().child("Users").child(userID!).updateChildValues(["Flip Counter": currentCounter])
            }
            
            title = " Game Over"
            message = " You Won with \(flipCounter) flips"
            timer?.invalidate()
            
        }
        else
        {
            if milliseconds > 0
            {
                flipCounter = flipCounter + 1
                flipsCount.text = "Flips: \(flipCounter)"
                return
            }
            title = " Game Over"
            message = " You Lost with \(flipCounter) flips"
        }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func timerCountDown()
    {
        milliseconds = milliseconds - 1
        let seconds = String(format: "%.2f", milliseconds / 1000)
        countDown.text = "Count Down: \(seconds)"
        if milliseconds <= 0
        {
            timer?.invalidate()
            countDown.textColor = UIColor.red
            endOfGame()
        }
    }
    
    @IBAction func menuButton(_ sender: UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewMenuController = storyboard.instantiateViewController(withIdentifier: "ViewMenuController") as! ViewMenuController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    @IBAction func scoresButton(_ sender: UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewScoresController = storyboard.instantiateViewController(withIdentifier: "ViewScoresController") as! ViewScoresController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
