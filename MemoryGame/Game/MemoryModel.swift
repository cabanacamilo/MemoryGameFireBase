//
//  MemoryModel.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/10/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import Foundation

class memoryModel
{
    var choices = ["👻","🍬","🦇","🎃","☠️","😱","👿","🤡","🍭","🍫","🧙🏼‍♂️","🧟‍♂️","🧛‍♀️","🕷"]
    var generateCards = [Card]()
    var firstFlippedCard: Int?
    var cardsAlredyGenerated = [Int]()
    
    var soundManager = SoundManager()
    
    func getCards(cardsNumber: Int)->[Card]
    {
        while cardsAlredyGenerated.count < cardsNumber
        {
            let random = Int(arc4random_uniform(UInt32(choices.count)))
            if cardsAlredyGenerated.contains(random) == false
            {
                let emojiOne = Card()
                emojiOne.cards = choices[random]
                generateCards.append(emojiOne)
                
                let emojiTwo = Card()
                emojiTwo.cards = choices[random]
                generateCards.append(emojiTwo)
                
                cardsAlredyGenerated.append(random)
            }
        }
        generateCards.shuffle()
        return generateCards
    }
    
    func chooseCard(at index: Int)
    {
        if generateCards[index].mached == false
        {
            if let matchCard = firstFlippedCard, matchCard != index
            {
                if generateCards[matchCard].cards == generateCards[index].cards
                {
                    generateCards[matchCard].mached = true
                    generateCards[index].mached = true
                    
                    soundManager.playSound(.match)
                }
                else
                {
                    generateCards[matchCard].mached = false
                    generateCards[index].mached = false
                    
                    soundManager.playSound(.noMatch)
                }
                generateCards[index].flipped = true
                firstFlippedCard = nil
            }
            else
            {
                for flipDownCard in generateCards.indices
                {
                    generateCards[flipDownCard].flipped = false
                }
                generateCards[index].flipped = true
                firstFlippedCard = index
            }
        }
    }
    
}

